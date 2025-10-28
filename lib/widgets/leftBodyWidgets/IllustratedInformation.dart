import 'package:car_dashboard/providers/GlobalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IllustratedInformation extends StatefulWidget {
  const IllustratedInformation({super.key, required this.gridCount});
  final int gridCount;

  @override
  State<IllustratedInformation> createState() => _IllustratedInformationState();
}

class _IllustratedInformationState extends State<IllustratedInformation> {
  @override
  void initState() {
    super.initState();
    // Precache all images to prevent flickering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('images/car/araba.png'), context);
      precacheImage(const AssetImage('images/car/arabal1.png'), context);
      precacheImage(const AssetImage('images/car/arabal2.png'), context);
      precacheImage(const AssetImage('images/car/arabal3.png'), context);
      precacheImage(const AssetImage('images/car/arabal4.png'), context);
      precacheImage(const AssetImage('images/car/arabal5.png'), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, globalProvider, child) {
        final bool isDippedBeamOn = globalProvider.dippedBeam;
        final bool isFullBeamOn = globalProvider.fullBeam;
        final bool isFogLightOn = globalProvider.fogLights;
        String lightState = "images/car/araba.png";

        if (!isDippedBeamOn && !isFullBeamOn && !isFogLightOn) {
          lightState = 'images/car/araba.png';
        } else if (isDippedBeamOn && !isFullBeamOn && !isFogLightOn) {
          lightState = 'images/car/arabal1.png';
        } else if (isDippedBeamOn && isFullBeamOn && !isFogLightOn) {
          lightState = 'images/car/arabal2.png';
        } else if (!isDippedBeamOn && !isFullBeamOn && isFogLightOn) {
          lightState = 'images/car/arabal3.png';
        } else if (isDippedBeamOn && isFullBeamOn && isFogLightOn) {
          lightState = 'images/car/arabal4.png';
        } else if (isDippedBeamOn && !isFullBeamOn && isFogLightOn) {
          lightState = 'images/car/arabal5.png';
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            // Image'a doğrudan boyut vermek yerine kısıtlama (constraints) belirliyoruz.
            constraints: BoxConstraints(
              // width yerine maxWidth kullanın
              maxWidth: (MediaQuery.of(context).size.width / widget.gridCount) - 16,
              // height yerine maxHeight kullanın
              maxHeight: MediaQuery.of(context).size.height - 180,
            ),
            child: Image.asset(
              lightState,
              fit: BoxFit.contain,
              // Image widget'ından width ve height özelliklerini kaldırın
            ),
          ),
        );
      },
    );
  }
}
