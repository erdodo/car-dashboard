import 'package:car_dashboard/providers/GlobalProvider.dart';
import 'package:car_dashboard/widgets/bodyLayout/CenterBody.dart';
import 'package:car_dashboard/widgets/bodyLayout/LeftBody.dart';
import 'package:car_dashboard/widgets/bodyLayout/RightBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Screens> screens = [
    Screens(id: 1, showCenterBody: false, gridCount: 2),
    Screens(id: 2, showCenterBody: true, gridCount: 3),
    Screens(id: 3, showCenterBody: false, gridCount: 2),
  ];
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 160,

      child:Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          final int screenIndex = globalProvider.homeScreenIndex;
          var selectedScreen = screens.firstWhere((s) => s.id == screenIndex);
          return  Row(
            children: [

              Container(
                width: MediaQuery.of(context).size.width /selectedScreen.gridCount,
                child: Leftbody(selectedScreen: selectedScreen),
              ),
              selectedScreen.showCenterBody? Container(
                width: MediaQuery.of(context).size.width /3,
                child: Centerbody(),
              ):SizedBox(width: 0,),
              Container(
                width: MediaQuery.of(context).size.width /selectedScreen.gridCount,
                child: Rightbody(selectedScreen: selectedScreen,),
              )


            ],
          );
        },
      ),
    );
  }
}

class Screens {
  final int id;
  final bool showCenterBody;
  final int gridCount;

  Screens({
    required this.id,
    required this.showCenterBody,
    required this.gridCount,
  });
}