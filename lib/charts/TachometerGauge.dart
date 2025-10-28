import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TachometerGauge extends StatefulWidget {
  const TachometerGauge({super.key, required this.rpmValue, this.gridCount=2});
  final int gridCount;
  final double rpmValue;

  @override
  State<TachometerGauge> createState() => _TachometerGaugeState();
}

class _TachometerGaugeState extends State<TachometerGauge> {
  double rpmValue = 8;
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        rpmValue = 0;
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          rpmValue = widget.rpmValue;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // --- YENİ EKLENDİ: Koyu Arka Plan Konteyneri ---
    // Daha profesyonel ve havalı bir görünüm için gradyan arka plan.
    return Container(

      child: SizedBox(
        width: MediaQuery.of(context).size.width / widget.gridCount,
        child: AspectRatio(
          aspectRatio: 1.0, // Genişlik = Yükseklik
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                // Takometre genellikle tam daire değildir
                startAngle: 150, // Başlangıç açısı
                endAngle: 30, // Bitiş açısı
                minimum: 0, // Minimum RPM değeri (x1000)
                maximum: 8, // Maksimum RPM değeri (x1000)
                showLabels: true, // 0, 1, 2, ... etiketlerini göster
                showTicks: true, // Ana ve ara çentikleri göster
                minorTicksPerInterval: 4, // Her ana aralıkta 4 ara çentik (0.2'lik adımlar)
                labelOffset: 15, // Etiketlerin eksenden uzaklığı

                // --- ESTETİK GÜNCELLEME: Etiket Stili ---
                axisLabelStyle: const GaugeTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white70, // Koyu arka plan için renk değişti
                ),

                // --- ESTETİK GÜNCELLEME: Eksen Arka Planı ---
                // Arka plana fırçalanmış metal hissi veren koyu bir çember eklendi
                axisLineStyle: AxisLineStyle(
                  thickness: 0.1,
                  color: Colors.grey.shade800,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),

                // --- ESTETİK GÜNCELLEME: Çentik Stilleri ---
                majorTickStyle: MajorTickStyle(
                  length: 0.1,
                  thickness: 2,
                  lengthUnit: GaugeSizeUnit.factor,
                  color: Colors.white54, // Koyu arka plan için renk değişti
                ),
                minorTickStyle: MinorTickStyle(
                  length: 0.05,
                  thickness: 1,
                  lengthUnit: GaugeSizeUnit.factor,
                  color: Colors.white38, // Koyu arka plan için renk değişti
                ),

                ranges: <GaugeRange>[
                  // Normal hız aralığı (0-160)
                  GaugeRange(
                    startValue: 0,
                    endValue: 6, // 220'nin yaklaşık %70-75'i
                    color: Colors.cyan,
                    startWidth: 0.01,
                    endWidth: 0.02,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                  // Yüksek hız bölgesi (160-220)
                  GaugeRange(
                    startValue: 6,
                    endValue: 8,
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
                    value: rpmValue, // Değer artık speedValue'dan geliyor
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
                // --- Ek Bilgiler (Anotasyonlar) ---
                annotations: <GaugeAnnotation>[
                  // 'RPM x1000' metni
                  GaugeAnnotation(
                    widget: Text(
                      'RPM x1000',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.6), // Renk değişti
                      ),
                    ),
                    angle: 90, // Metnin gösterge üzerindeki açısı (90 derece = alt orta)
                    positionFactor: 0.75, // Merkeze olan uzaklık
                  ),
                  // Anlık RPM değerini gösteren dijital ekran
                  GaugeAnnotation(
                    widget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      // --- ESTETİK GÜNCELLEME: Dijital Ekran Görünümü ---
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
                        // Değeri 1000 ile çarpıp tam sayı olarak göster
                        (rpmValue * 1000).toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          // --- ESTETİK GÜNCELLEME: Dijital Ekran Rengi ---
                          color: Colors.lightGreenAccent.shade400,
                          fontFamily: 'monospace', // Dijital saat görünümü için
                        ),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.45,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

