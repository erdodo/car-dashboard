import 'package:car_dashboard/charts/SpeedometerGauge.dart';
import 'package:car_dashboard/skeleton/Body.dart';
import 'package:car_dashboard/widgets/HRAppLauncher.dart';
import 'package:car_dashboard/widgets/rightBodyWidgets/ExteriorLights.dart';
import 'package:flutter/material.dart';

class Rightbody extends StatefulWidget {
  const Rightbody({super.key, required this.selectedScreen});
  final Screens selectedScreen;

  @override
  State<Rightbody> createState() => _RightbodyState();
}

class _RightbodyState extends State<Rightbody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.selectedScreen.id == 1 ? ExteriorLights() : Container(),
        widget.selectedScreen.id == 2
            ? SpeedometerGauge(
                speedValue: 120,
                gridCount: widget.selectedScreen.gridCount,
              )
            : Container(),
        widget.selectedScreen.id == 3
            ? Row(children: [HRAppLauncher()])
            : Container(),
      ],
    );
  }
}
