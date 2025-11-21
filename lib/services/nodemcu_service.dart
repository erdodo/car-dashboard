import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NodeMCUService {
  static const String baseUrl = 'http://car-brain.local';

  static Future<bool> testConnection() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));
      print('Test basarili: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Test basarisiz: $e');
      return false;
    }
  }

  StreamController<Map<String, dynamic>>? _eventController;
  http.Client? _client;
  bool _isConnected = false;

  Stream<Map<String, dynamic>> connectToEventStream() {
    if (_eventController != null && !_eventController!.isClosed) {
      return _eventController!.stream;
    }
    _eventController = StreamController<Map<String, dynamic>>.broadcast();
    _startListening();
    return _eventController!.stream;
  }

  Future<void> _startListening() async {
    _isConnected = true;

    while (_isConnected) {
      try {
        _client = http.Client();
        final request = http.Request('GET', Uri.parse('$baseUrl/events'));
        request.headers.addAll({
          'Accept': 'text/event-stream',
          'Cache-Control': 'no-cache',
          'Connection': 'keep-alive',
        });

        final response = await _client!
            .send(request)
            .timeout(const Duration(seconds: 10));
        print('Baglandi: ${response.statusCode}');

        if (response.statusCode == 200) {
          String buffer = '';
          String? currentEvent;

          await for (var chunk in response.stream.transform(utf8.decoder)) {
            if (!_isConnected) break;
            buffer += chunk;

            while (buffer.contains('\n')) {
              final lineEnd = buffer.indexOf('\n');
              final line = buffer.substring(0, lineEnd).trim();
              buffer = buffer.substring(lineEnd + 1);

              if (line.isEmpty) {
                currentEvent = null;
                continue;
              }

              if (line.startsWith('event:')) {
                currentEvent = line.substring(6).trim();
              } else if (line.startsWith('data:')) {
                final dataStr = line.substring(5).trim();

                if (currentEvent == 'state' && dataStr.isNotEmpty) {
                  try {
                    final data = json.decode(dataStr);
                    if (data is Map<String, dynamic>) {
                      _eventController?.add(data);
                    }
                  } catch (e) {
                    print('Parse error: $e');
                  }
                }
              }
            }
          }
        }
      } catch (e) {
        print('Hata: $e');
        await Future.delayed(const Duration(seconds: 5));
      } finally {
        _client?.close();
      }

      if (_isConnected) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  void disconnect() {
    _isConnected = false;
    _client?.close();
    _eventController?.close();
    _eventController = null;
  }

  bool get isConnected => _isConnected;
}
