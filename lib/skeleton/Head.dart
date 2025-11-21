import 'package:car_dashboard/providers/GlobalProvider.dart';
import 'package:car_dashboard/widgets/headerWidgets/BrightnessWidget.dart';
import 'package:car_dashboard/widgets/headerWidgets/ODBConnection.dart';
import 'package:car_dashboard/widgets/headerWidgets/WatchTime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Head extends StatefulWidget {
  const Head({super.key});

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [BrightnessWidget(), Odbconnection()]),
          Watchtime(),
          Consumer<GlobalProvider>(
            builder: (context, globalProvider, child) {
              final int screenIndex = globalProvider.homeScreenIndex;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      globalProvider.setHomeScreenIndex(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: screenIndex == 1
                          ? Colors.cyan
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Ekran 1"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      globalProvider.setHomeScreenIndex(2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: screenIndex == 2
                          ? Colors.cyan
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Ekran 2"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      globalProvider.setHomeScreenIndex(3);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: screenIndex == 3
                          ? Colors.cyan
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Ekran 3"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
