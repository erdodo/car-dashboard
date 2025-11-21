import 'package:flutter/material.dart';

// Basit placeholder widget (Android 5 uyumluluk testi için)
class TachometerGauge extends StatefulWidget {
  const TachometerGauge({super.key, required this.rpmValue, this.gridCount = 2});
  final int gridCount;
  final double rpmValue;

  @override
  State<TachometerGauge> createState() => _TachometerGaugeState();
}

class _TachometerGaugeState extends State<TachometerGauge> {
  double rpmValue = 8;

  @override
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / widget.gridCount,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.lightGreenAccent.withOpacity(0.3), width: 2),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (rpmValue * 1000).toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent.shade400,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'RPM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

