import 'package:car_dashboard/skeleton/Body.dart';
import 'package:car_dashboard/skeleton/Footer.dart';
import 'package:car_dashboard/skeleton/Head.dart';
import 'package:car_dashboard/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final extras = appExtras(context);

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: MediaQuery.of(context).padding.top),

        child:Container(
          decoration: BoxDecoration(gradient: extras.backgroundGradient),
          child: Column(children: <Widget>[Head(), Body(), Footer()]),
        )

      ),
    );
  }
}
