import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/*
  ÖNEMLİ KURULUM NOTLARI:

  1. 'intl' Paketini Ekleyin:
     Bu kodun çalışması için 'intl' paketine ihtiyacınız var.
     'pubspec.yaml' dosyanıza şu satırı ekleyin:

     dependencies:
       flutter:
         sdk: flutter
       intl: ^0.19.0 # (veya 'dart pub add intl' komutuyla en son sürümü ekleyin)

  2. Türkçe Yerelleştirmeyi Başlatın:
     'DateFormat' ile Türkçe tarih (Pazartesi, Ekim vb.) adlarını doğru
     görüntülemek için uygulamanızın 'main.dart' dosyasındaki 'main'
     fonksiyonunu aşağıdaki gibi güncellemeniz gerekir:

     void main() async {

       WidgetsFlutterBinding.ensureInitialized();


       await initializeDateFormatting('tr_TR', null);


       runApp(const MyApp());
     }
*/

class Watchtime extends StatefulWidget {
  const Watchtime({super.key});

  @override
  State<Watchtime> createState() => _WatchtimeState();
}

class _WatchtimeState extends State<Watchtime> {
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedHour = DateFormat('HH').format(_currentTime);
    String formattedMinute = DateFormat('mm').format(_currentTime);


    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                formattedHour,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              Text(
                ':',
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              Text(
                formattedMinute,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),

            ],
          ),

          /* Text(
            formattedDate,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),*/
        ],
      ),
    );
  }
}
