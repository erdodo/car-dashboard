import 'package:car_dashboard/providers/GlobalProvider.dart';
import 'package:car_dashboard/widgets/centerBodyWidgets/WarningLights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Centerbody extends StatefulWidget {
  const Centerbody({super.key});

  @override
  State<Centerbody> createState() => _CenterbodyState();
}

class _CenterbodyState extends State<Centerbody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WarningLights(),
        Consumer<GlobalProvider>(
          builder: (context, globalProvider, child) {
            final bool isDippedBeamOn = globalProvider.dippedBeam;
            final bool isFullBeamOn = globalProvider.fullBeam;
            final bool isFogLightOn = globalProvider.fogLights;

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SvgPicture.asset(
                    "images/icons/low-beam-headlights-line.svg",
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      isDippedBeamOn ? Colors.cyan : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/icons/hight-beam-headlights-line.svg",
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      isFullBeamOn ? Colors.cyan : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  SvgPicture.asset(
                    "images/icons/front-fog-lights-line.svg",
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      isFogLightOn ? Colors.cyan : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
