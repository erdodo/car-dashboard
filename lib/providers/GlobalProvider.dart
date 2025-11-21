import 'package:flutter/material.dart';
import 'dart:async';
import '../services/nodemcu_service.dart';

class GlobalProvider extends ChangeNotifier {
  bool _dippedBeam = false; //kısa far
  bool _fullBeam = false; //uzun far
  bool _fogLights = false; //sis farı

  int homeScreenIndex = 1;

  // NodeMCU Sensör Verileri
  String _bagliAg = '';
  bool _hareketAlgilandi = false;
  String _ipAdresi = '';
  double _nem = 0.0;
  bool _ortamIsikDurumu = false;
  double _sicaklik = 0.0;
  int _wifiCekimGucu = 0;
  String _yazilimVersionu = '';
  double _calismaSuresi = 0.0;

  // NodeMCU Service
  final NodeMCUService _nodeMCUService = NodeMCUService();
  StreamSubscription? _eventSubscription;
  bool _isNodeMCUConnected = false;

  bool get dippedBeam => _dippedBeam;
  bool get fullBeam => _fullBeam;
  bool get fogLights => _fogLights;

  // NodeMCU Getters
  String get bagliAg => _bagliAg;
  bool get hareketAlgilandi => _hareketAlgilandi;
  String get ipAdresi => _ipAdresi;
  double get nem => _nem;
  bool get ortamIsikDurumu => _ortamIsikDurumu;
  double get sicaklik => _sicaklik;
  int get wifiCekimGucu => _wifiCekimGucu;
  String get yazilimVersionu => _yazilimVersionu;
  double get calismaSuresi => _calismaSuresi;
  bool get isNodeMCUConnected => _isNodeMCUConnected;

  set dippedBeam(bool value) {
    _dippedBeam = value;
  }

  set fullBeam(bool value) {
    _fullBeam = value;
  }

  set fogLights(bool value) {
    _fogLights = value;
  }

  toggleDippedBeam() {
    _dippedBeam = !_dippedBeam;
    if (!_dippedBeam) {
      _fullBeam = false;
    }
    notifyListeners();
  }

  toggleFullBeam() {
    _fullBeam = !_fullBeam;
    if (_fullBeam) {
      _dippedBeam = true;
    }
    notifyListeners();
  }

  toggleFogLights() {
    _fogLights = !_fogLights;
    notifyListeners();
  }

  setHomeScreenIndex(int index) {
    homeScreenIndex = index;
    notifyListeners();
  }

  // NodeMCU Bağlantısı
  void connectToNodeMCU() async {
    if (_isNodeMCUConnected) {
      print('⚠️ NodeMCU zaten bağlı');
      return;
    }

    print('🚀 GlobalProvider: NodeMCU bağlantısı başlatılıyor...');

    // Önce basit bir test yap
    final canConnect = await NodeMCUService.testConnection();
    if (!canConnect) {
      print('❌ NodeMCU\'ya erişilemiyor. IP doğru mu? (192.168.1.120)');
      return;
    }

    try {
      _eventSubscription = _nodeMCUService.connectToEventStream().listen(
        (data) {
          if (!_isNodeMCUConnected) {
            _isNodeMCUConnected = true;
            print('✅ GlobalProvider: NodeMCU bağlantısı kuruldu');
            notifyListeners();
          }
          _processNodeMCUData(data);
        },
        onError: (error) {
          print('❌ GlobalProvider: NodeMCU stream error: $error');
          _isNodeMCUConnected = false;
          notifyListeners();
        },
        onDone: () {
          print('⚠️ GlobalProvider: NodeMCU stream kapandı');
          _isNodeMCUConnected = false;
          notifyListeners();
        },
      );
    } catch (e) {
      print('❌ GlobalProvider: NodeMCU connection error: $e');
      _isNodeMCUConnected = false;
      notifyListeners();
    }
  }

  void disconnectFromNodeMCU() {
    _eventSubscription?.cancel();
    _nodeMCUService.disconnect();
    _isNodeMCUConnected = false;
    notifyListeners();
  }

  void _processNodeMCUData(Map<String, dynamic> data) {
    final id = data['id'] as String?;
    if (id == null) {
      print('⚠️ Veri ID\'si yok: $data');
      return;
    }

    print('🔄 Processing: $id = ${data['value']}');

    switch (id) {
      case 'text_sensor-ba_l__a_':
        _bagliAg = data['value']?.toString() ?? '';
        print('✅ Bağlı Ağ güncellendi: $_bagliAg');
        break;
      case 'binary_sensor-hareket_alg_land_':
        _hareketAlgilandi = data['value'] == true;
        print('✅ Hareket sensörü güncellendi: $_hareketAlgilandi');
        break;
      case 'text_sensor-ip_adresi':
        _ipAdresi = data['value']?.toString() ?? '';
        print('✅ IP adresi güncellendi: $_ipAdresi');
        break;
      case 'sensor-nem':
        _nem = (data['value'] is num) ? (data['value'] as num).toDouble() : 0.0;
        print('✅ Nem güncellendi: $_nem%');
        break;
      case 'binary_sensor-ortam_i__k_durumu':
        _ortamIsikDurumu = data['value'] == true;
        print('✅ Işık durumu güncellendi: $_ortamIsikDurumu');
        break;
      case 'sensor-s_cakl_k':
        _sicaklik = (data['value'] is num)
            ? (data['value'] as num).toDouble()
            : 0.0;
        print('✅ Sıcaklık güncellendi: $_sicaklik°C');
        break;
      case 'sensor-wifi__ekim_g_c_':
        _wifiCekimGucu = (data['value'] is num)
            ? (data['value'] as num).toInt()
            : 0;
        print('✅ WiFi gücü güncellendi: $_wifiCekimGucu dBm');
        break;
      case 'text_sensor-yaz_l_m_versiyonu':
        _yazilimVersionu = data['value']?.toString() ?? '';
        print('✅ Yazılım versiyonu güncellendi: $_yazilimVersionu');
        break;
      case 'sensor-_al__ma_s_resi':
        _calismaSuresi = (data['value'] is num)
            ? (data['value'] as num).toDouble()
            : 0.0;
        print('✅ Çalışma süresi güncellendi: $_calismaSuresi s');
        break;
      default:
        print('⚠️ Bilinmeyen sensor ID: $id');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    disconnectFromNodeMCU();
    super.dispose();
  }
}
