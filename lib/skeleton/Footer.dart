import 'package:car_dashboard/widgets/footerWidgets/FastClimate.dart';
import 'package:car_dashboard/widgets/footerWidgets/NodeMCUClimateWidget.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Fastclimate(), NodeMCUClimateWidget()],
      ),
    );
  }
}
