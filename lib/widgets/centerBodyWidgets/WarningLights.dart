import 'package:car_dashboard/widgets/leftBodyWidgets/IllustratedInformation.dart';
import 'package:flutter/material.dart';

class WarningLights extends StatefulWidget {
  const WarningLights({super.key});

  @override
  State<WarningLights> createState() => _WarningLightsState();
}

class _WarningLightsState extends State<WarningLights> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      IllustratedInformation(gridCount: 4,)
      ],
    );
  }
}
