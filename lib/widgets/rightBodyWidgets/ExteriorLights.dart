import 'package:car_dashboard/providers/GlobalProvider.dart';
import 'package:car_dashboard/widgets/rightBodyWidgets/CustomToggleButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExteriorLights extends StatefulWidget {
  const ExteriorLights({super.key});

  @override
  State<ExteriorLights> createState() => _ExteriorLightsState();
}

class _ExteriorLightsState extends State<ExteriorLights> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Consumer<GlobalProvider>(
      builder: (context, globalProvider, child) {
        final bool isDippedBeamOn = globalProvider.dippedBeam;
        final bool isFullBeamOn = globalProvider.fullBeam;
        final bool isFogLightsOn = globalProvider.fogLights;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomToggleButton(
              isOn: isDippedBeamOn,
              label: "Kısa Farlar",
              icon: "images/icons/low-beam-headlights-line.svg",
              onPressed: () {
                globalProvider.toggleDippedBeam();
              },
            ),
            CustomToggleButton(
              isOn: isFullBeamOn,
              label: "Uzun Farlar",
              icon: "images/icons/hight-beam-headlights-line.svg",
              onPressed: () {
                globalProvider.toggleFullBeam();
              },
            ),
            CustomToggleButton(
              isOn: isFogLightsOn,
              label: "Sis Farları",
              icon: "images/icons/front-fog-lights-line.svg",
              onPressed: () {
                globalProvider.toggleFogLights();
              },
            ),
          ],
        );
      },

    ),) 
       ;
  }
}
