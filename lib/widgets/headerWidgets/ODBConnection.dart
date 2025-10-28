import 'dart:async'; // Future.delayed için eklendi
import 'package:flutter/material.dart';

class Odbconnection extends StatefulWidget {
  const Odbconnection({super.key});

  @override
  State<Odbconnection> createState() => _OdbconnectionState();
}

class _OdbconnectionState extends State<Odbconnection> {
  // Cihazın bağlı olup olmadığını takip eden state
  bool _isConnected = false;
  // Şu anda bağlanmaya çalışıp çalışmadığını takip eden state (otomatik veya manuel)
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    // Widget başlar başlamaz arka planda otomatik bağlanmayı dene
    _autoConnect();
  }

  /// Arka planda otomatik bağlanmayı simüle eder.
  Future<void> _autoConnect() async {
    // Sadece bağlı değilse ve zaten bir deneme yoksa çalıştır
    if (!_isConnected && !_isConnecting) {
      if (mounted) {
        setState(() {
          _isConnecting = true;
        });
      }

      // --- GERÇEK UYGULAMA YORUMU ---
      // Burada, daha önce kaydedilmiş bir OBD cihazına (örn: SharedPreferences'tan)
      // otomatik bağlanmayı deneyen gerçek Bluetooth kodunuz olmalı.
      // --- Simülasyon Başlangıcı ---
      print("Otomatik bağlanma denemesi başlıyor...");
      await Future.delayed(const Duration(seconds: 3));
      // Simülasyon: Otomatik bağlanma başarısız oldu diyelim.
      print("Otomatik bağlanma başarısız oldu.");
      // --- Simülasyon Sonu ---

      // Widget hala ekrandaysa state'i güncelle
      if (mounted) {
        setState(() {
          _isConnecting = false;
          // _isConnected = true; // Eğer başarılı olsaydı
        });
      }
    }
  }

  /// Tıklandığında cihaz listesini gösteren modal'ı açar.
  void _showDeviceListModal(BuildContext context) {
    showDialog(
      context: context,
      // "arkası hafif karanlık"
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext dialogContext) {
        // Modal içindeki tarama durumu ve cihaz listesi için
        // StatefulBuilder kullanıyoruz.
        return StatefulBuilder(
          builder: (context, modalSetState) {
            bool isScanning = false;
            List<String> discoveredDevices = [];

            // Modal açıldığında taramayı başlatan yardımcı fonksiyon
            void scanForDevices() async {
              if (isScanning) return; // Zaten taranıyorsa tekrar başlatma

              modalSetState(() {
                isScanning = true;
                discoveredDevices = [];
              });

              // --- GERÇEK UYGULAMA YORUMU ---
              // Burası `flutter_blue_plus.startScan()` gibi
              // gerçek Bluetooth tarama kodunuzun olacağı yer.
              // --- Simülasyon Başlangıcı ---
              print("Bluetooth cihazları taranıyor...");
              await Future.delayed(const Duration(seconds: 2));
              // Simülasyon: Sahte cihazlar bulundu
              discoveredDevices = [
                "OBDII-1234",
                "VLink-5678",
                "MyCar-BLE",
                "Bluetooth-Cihazı"
              ];
              print("Tarama tamamlandı. Cihazlar: $discoveredDevices");
              // --- Simülasyon Sonu ---

              modalSetState(() {
                isScanning = false;
              });
            }

            // Modal ilk açıldığında taramayı başlat
            if (discoveredDevices.isEmpty && !isScanning) {
              scanForDevices();
            }

            return Dialog(
              // "çerçeveleri cyanAccent olan"
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(
                  color: Colors.cyanAccent,
                  width: 2.0,
                ),
              ),
              // "hafif gölgeli"
              elevation: 10.0,
              backgroundColor: Colors.grey[900], // Koyu tema için
              child: Container(
                padding: const EdgeInsets.all(20.0),
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bluetooth Cihazları",
                      style: TextStyle(
                        color: Colors.cyanAccent[100],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // İçerik: Tarama veya Liste
                    Expanded(
                      child: isScanning
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyanAccent,
                        ),
                      )
                          : discoveredDevices.isEmpty
                          ? Center(
                        child: Text(
                          "Cihaz bulunamadı.",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      )
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: discoveredDevices.length,
                        itemBuilder: (context, index) {
                          final deviceName = discoveredDevices[index];
                          return ListTile(
                            leading: Icon(
                              Icons.bluetooth_drive,
                              color: Colors.cyanAccent[100],

                            ),
                            title: Text(
                              deviceName,
                              style: const TextStyle(
                                  color: Colors.white),
                            ),
                            onTap: () {
                              // Cihaza bağlanmayı dene
                              _connectToDevice(deviceName);
                              // Modal'ı kapat
                              Navigator.of(dialogContext).pop();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Kapat Butonu
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        "Kapat",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Seçilen bir cihaza bağlanmayı simüle eder.
  Future<void> _connectToDevice(String deviceName) async {
    if (mounted) {
      setState(() {
        _isConnecting = true;
      });
    }

    // --- GERÇEK UYGULAMA YORUMU ---
    // Burası seçilen cihaza (`deviceName` veya BluetoothDevice nesnesi)
    // bağlanmayı deneyen gerçek kodunuz.
    // --- Simülasyon Başlangıcı ---
    print("$deviceName adlı cihaza bağlanılıyor...");
    await Future.delayed(const Duration(seconds: 2));
    // Simülasyon: Bağlantı başarılı oldu
    print("Bağlantı başarılı!");
    // --- Simülasyon Sonu ---

    if (mounted) {
      setState(() {
        _isConnecting = false;
        _isConnected = true; // Bağlantı başarılı!
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Bağlantı denemesi sırasında ikonu gizleyip yükleme göstergesi koyalım
    if (_isConnecting) {
      // Yükleme göstergesinin ikonla aynı alanı kaplaması için SizedBox
      return Container(
        width: 48.0,
        height: 48.0,
        padding: const EdgeInsets.all(12.0), // IconButton padding'i ile eşleşir
        child: const CircularProgressIndicator(
          color: Colors.cyanAccent,
          strokeWidth: 3.0,
        ),
      );
    }

    // Bağlı veya bağlantı yok durumunda ikonu göster
    return IconButton(
      icon: Icon(
        // Bağlıyken farklı bir ikon da gösterebilirsiniz
        _isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
        size: 30,
      ),
      // "eğer ki bir odb cihazına bağlandı ise cyanAccent renginde olacak"
      color: _isConnected ? Colors.cyanAccent : Colors.grey[600],
      tooltip: _isConnected ? "OBD Bağlı" : "OBD Bağlantısı Kesildi",
      onPressed: () {
        // "tıklanırsa bir modal açılacak"
        _showDeviceListModal(context);
      },
    );
  }
}
