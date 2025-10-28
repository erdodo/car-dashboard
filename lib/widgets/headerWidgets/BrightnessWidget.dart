import 'package:car_dashboard/widgets/SlidingMenuContainer.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart'; // Eklentiyi içe aktar
import 'dart:async'; // *** HATA DÜZELTMESİ: 'dart;' -> 'dart:async;' ***

class BrightnessWidget extends StatefulWidget {
  const BrightnessWidget({super.key});

  @override
  State<BrightnessWidget> createState() => _BrightnessWidgetState();
}

class _BrightnessWidgetState extends State<BrightnessWidget> {
  double _currentBrightness = 0.5;
  bool menuOpen = false;
  bool get isAutoBrightness => _currentBrightness == 0.0;

  @override
  void initState() {
    super.initState();
    _initBrightness();
  }

  Future<void> _initBrightness() async {
    try {
      final double brightness = await ScreenBrightness().current;
      setState(() {
        _currentBrightness = brightness;
      });
    } catch (e) {
      debugPrint('Mevcut parlaklık alınamadı: $e');
    }
  }

  Future<void> _setBrightness(double brightness) async {
    setState(() {
      _currentBrightness = brightness;
    });

    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      debugPrint('Parlaklık ayarlanamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingMenuContainer(
      isOpen: menuOpen, // state'deki bool değişkeni
      mainContent: IconButton(
        icon: const Icon(Icons.brightness_6),
        color: Colors.white,
        iconSize: 30,
        tooltip: 'Parlaklığı Ayarla',
        onPressed: () {
          setState(() {
            menuOpen = !menuOpen;
          });
        },
      ),
      menuContent: Material(
        color: Colors.transparent,
        child: Container(
          width: 250, // Menü genişliği
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Slider(
                  // *** DEĞİŞİKLİK: Değer, min(0.01) ve max(1.0) arasına sıkıştırıldı ***
                  // _currentBrightness 0.0 (Auto) olduğunda slider'ın çökmesini engeller.
                  value: _currentBrightness.clamp(0.01, 1.0),
                  // *** DEĞİŞİKLİK: Minimum değer 0.01 (1%) olarak ayarlandı ***
                  min: 0.01,
                  max: 1.0,
                  activeColor: Colors.cyanAccent,
                  inactiveColor: Colors.blueGrey.shade700,
                  onChanged: (value) {
                    // Eklentiyi kullanarak parlaklığı ayarla
                    _setBrightness(value);
                  },
                ),
              ),
              // *** DEĞİŞİKLİK: Icons.brightness_high yerine "Auto" butonu eklendi ***
              TextButton(
                onPressed: () {
                  _setBrightness(0.0);
                },
                style: TextButton.styleFrom(
                  foregroundColor: isAutoBrightness
                      ? Colors.cyan
                      : Colors.grey, // Dinamik renk
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30), // Tıklama alanı
                ),
                child: const Text(
                  'Auto',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
