import 'package:car_dashboard/skeleton/Body.dart';
import 'package:car_dashboard/skeleton/Footer.dart';
import 'package:car_dashboard/skeleton/Head.dart';
import 'package:car_dashboard/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_dashboard/providers/GlobalProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // NodeMCU bağlantısını başlat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GlobalProvider>(context, listen: false).connectToNodeMCU();
    });
  }

  @override
  Widget build(BuildContext context) {
    final extras = appExtras(context);

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: MediaQuery.of(context).padding.top),

        child: Container(
          decoration: BoxDecoration(gradient: extras.backgroundGradient),
          child: Column(children: <Widget>[Head(), Body(), Footer()]),
        ),
      ),
    );
  }
}
