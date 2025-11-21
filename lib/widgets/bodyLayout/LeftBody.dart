import 'package:car_dashboard/charts/TachometerGauge.dart';
import 'package:car_dashboard/skeleton/Body.dart';
import 'package:car_dashboard/widgets/NodeMCUDataTable.dart';
import 'package:car_dashboard/widgets/leftBodyWidgets/IllustratedInformation.dart';
import 'package:flutter/material.dart';

class Leftbody extends StatefulWidget {
  const Leftbody({super.key, required this.selectedScreen});

  final Screens selectedScreen;

  @override
  State<Leftbody> createState() => _LeftbodyState();
}

class _LeftbodyState extends State<Leftbody> {
  int screen = 2;
  // 1 araba resmi ışıklı gösterge
  // 2 devir göstergesi
  double rpmValue = 3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.selectedScreen.id == 1
            ? IllustratedInformation(gridCount: widget.selectedScreen.gridCount)
            : Container(),
        widget.selectedScreen.id == 2
            ? TachometerGauge(
                rpmValue: rpmValue,
                gridCount: widget.selectedScreen.gridCount,
              )
            : Container(),
        widget.selectedScreen.id == 3 ? NodeMCUDataTable() : Container(),
      ],
    );
  }
}
