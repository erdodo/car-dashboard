import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Orijinal TachometerGauge'un birebir aynısı, ancak hız için uyarlandı.
class SpeedometerGauge extends StatefulWidget {
  const SpeedometerGauge({super.key, required this.speedValue, this.gridCount = 2});
  final int gridCount;

  // Değişken adı RPM'den speed'e güncellendi
  final double speedValue;

  @override
  State<SpeedometerGauge> createState() => _SpeedometerGaugeState();
}

class _SpeedometerGaugeState extends State<SpeedometerGauge> {
  // Başlangıç animasyonu için maksimum değer yeni maks hız (220) olarak ayarlandı
  double speedValue = 220;

  @override
  void initState() {
    super.initState();
    // Orijinal koddaki "kadran selamlama" animasyonu korundu
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        speedValue = 0; // Önce sıfıra düş
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          // Sonra widget'tan gelen asıl hıza ayarla
          speedValue = widget.speedValue;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Koyu arka plan ve genel yerleşim (Container, SingleChildScrollView, Padding, vb.)
    // orijinal tasarımla aynı tutuldu.
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.gridCount,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              // Kadran açıları (150-30) aynı
              startAngle: 150,
              endAngle: 30,
              // --- GÜNCELLEME: Minimum ve Maksimum Değerler ---
              minimum: 0, // Minimum hız
              maximum: 220, // Maksimum hız (istendiği gibi)
              // --- GÜNCELLEME: Aralıklar ---
              // 0'dan 220'ye kadar 20'lik aralıklar (0, 20, 40, ...)
              interval: 20,
              showLabels: true,
              showTicks: true,
              // 20'lik her aralıkta 4 ara çentik (5 bölme, her biri 4 km/s)
              minorTicksPerInterval: 4,
              labelOffset: 15,
              // --- ESTETİK (Orijinal ile aynı) ---
              axisLabelStyle: const GaugeTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white70,
              ),
              axisLineStyle: AxisLineStyle(
                thickness: 0.1,
                color: Colors.grey.shade800,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              majorTickStyle: MajorTickStyle(
                length: 0.1,
                thickness: 2,
                lengthUnit: GaugeSizeUnit.factor,
                color: Colors.white54,
              ),
              minorTickStyle: MinorTickStyle(
                length: 0.05,
                thickness: 1,
                lengthUnit: GaugeSizeUnit.factor,
                color: Colors.white38,
              ),

              // --- GÜNCELLEME: Hız Aralıkları (Normal ve Hızlı) ---
              ranges: <GaugeRange>[
                // Normal hız aralığı (0-160)
                GaugeRange(
                  startValue: 0,
                  endValue: 160, // 220'nin yaklaşık %70-75'i
                  color: Colors.cyan,
                  startWidth: 0.01,
                  endWidth: 0.02,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
                // Yüksek hız bölgesi (160-220)
                GaugeRange(
                  startValue: 160,
                  endValue: 220,
                  gradient: SweepGradient(
                    colors: [
                      Colors.red.shade600,
                      Colors.red.shade300
                    ],
                    stops: const <double>[0.2, 0.8],
                  ),
                  startWidth: 0.01,
                  endWidth: 0.01,
                  sizeUnit: GaugeSizeUnit.factor,
                ),
              ],

              // --- GÜNCELLEME: İbre ---
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: speedValue, // Değer artık speedValue'dan geliyor
                  enableAnimation: true,
                  animationType: AnimationType.easeOutBack,
                  animationDuration: 800,
                  needleLength: 0.8,
                  lengthUnit: GaugeSizeUnit.factor,
                  needleStartWidth: 1,
                  needleEndWidth: 6,
                  needleColor: Colors.redAccent.shade200,
                  knobStyle: KnobStyle(
                    knobRadius: 0.08,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.grey.shade400,
                    borderColor: Colors.red,
                    borderWidth: 0.01,
                  ),
                  tailStyle: TailStyle(
                    length: 0.25,
                    lengthUnit: GaugeSizeUnit.factor,
                    width: 6,
                    color: Colors.redAccent.shade100,
                    borderColor: Colors.redAccent,
                    borderWidth: 2

                  ),
                ),
              ],

              // --- GÜNCELLEME: Ek Bilgiler (Anotasyonlar) ---
              annotations: <GaugeAnnotation>[
                // 'KM/H' metni
                GaugeAnnotation(
                  widget: Text(
                    'KM/H', // Metin 'RPM x1000'den 'KM/H'ye değişti
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.75, // Konum aynı
                ),
                // Anlık HIZ değerini gösteren dijital ekran
                GaugeAnnotation(
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      // Değer artık 1000 ile çarpılmıyor, direkt hızı gösteriyor
                      speedValue.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.45, // Konum aynı
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
