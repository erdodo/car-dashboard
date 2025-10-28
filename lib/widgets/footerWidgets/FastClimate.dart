import 'package:car_dashboard/widgets/MenuList.dart';
import 'package:car_dashboard/widgets/SlidingMenuContainer.dart';
import 'package:car_dashboard/widgets/footerWidgets/AnimatedFanIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Fastclimate extends StatefulWidget {
  const Fastclimate({super.key});

  @override
  State<Fastclimate> createState() => _FastclimateState();
}

class _FastclimateState extends State<Fastclimate> {
  List<ClimateMode> climateFanModes = [
    ClimateMode(
      id: 1,
      icon: 'images/climate/car-fan-mid-left-rounded.svg',
      label: "Yüz",
    ),
    ClimateMode(
      id: 2,
      icon: 'images/climate/car-fan-low-mid-left-rounded.svg',
      label: "Yüz & Ayak",
    ),
    ClimateMode(
      id: 3,
      icon: 'images/climate/car-fan-low-left-rounded.svg',
      label: "Ayak",
    ),
    ClimateMode(
      id: 4,
      icon: 'images/climate/car-defrost-low-left-rounded.svg',
      label: "Ayak & Cam",
    ),
    ClimateMode(
      id: 5,
      icon: 'images/climate/front-windshield-defroster-line.svg',
      label: "Cam",
    ),
  ];

  List<FanSpeed> fanSpeed = [
    FanSpeed(
      id: 1,
      icon: 'images/climate/fan-off.svg',
      label: "Kapalı",
      color: Colors.grey,
      speed: 0.0,
    ),
    FanSpeed(
      id: 2,
      icon: 'images/climate/fan.svg',
      label: "level 1",
      color: Colors.green,
      speed: 0.5,
    ),
    FanSpeed(
      id: 3,
      icon: 'images/climate/fan.svg',
      label: "level 2",
      color: Colors.yellow,
      speed: 1,
    ),
    FanSpeed(
      id: 4,
      icon: 'images/climate/fan.svg',
      label: "level 3",
      color: Colors.orange,
      speed: 1.5,
    ),
    FanSpeed(
      id: 5,
      icon: 'images/climate/fan.svg',
      label: "level 4",
      color: Colors.red,
      speed: 2,
    ),
  ];

  int selectedFanModeId = 1;
  int selectedFanSpeedId = 1;
  double temperature = 22.5;
  bool menuOpen = false;
  bool tempmenuOpen = false;

  @override
  Widget build(BuildContext context) {
    var selectedFanSpeed = fanSpeed.firstWhere(
      (mode) => mode.id == selectedFanSpeedId,
    );
    var selectedClimateFanModes = climateFanModes.firstWhere(
      (mode) => mode.id == selectedFanModeId,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 20),
        SlidingMenuContainer(
          isOpen: menuOpen, // state'deki bool değişkeni
          mainContent: IconButton(
            icon: SvgPicture.asset(
              selectedClimateFanModes.icon,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            onPressed: () {
              setState(() {
                menuOpen = !menuOpen;
              });
            },
          ),
          menuContent: Menulist(
            menuList: [
              ...climateFanModes.map((mode) {
                return IGlobalList(
                  id: mode.id,
                  label: mode.label,
                  color: Colors.white,
                  iconSvg: mode.icon,
                  onlyIcon: true,
                );
              }).toList(),
            ],
            onSelected: (id) {
              setState(() {
                selectedFanModeId = id;
                menuOpen = false;
              });
            },
          ),
        ),

        SizedBox(width: 10),

        SlidingMenuContainer(
          isOpen: tempmenuOpen, // state'deki bool değişkeni
          mainContent: TextButton(
            onPressed: () {
              setState(() {
                tempmenuOpen = !tempmenuOpen;
              });
            },
            child: Text(
              "$temperature°",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          menuContent: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    // Butonun kendi içindeki varsayılan boşlukları kaldırıyoruz
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(width: 1, color: Colors.cyan),
                    ),
                    onPressed: () {
                      setState(() {
                        temperature -= 0.5;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        temperature += 0.5;
                      });
                    },
                    child: Icon(Icons.add, color: Colors.redAccent,),
                  ),
                ),
              ],
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              selectedFanSpeedId += 1;
              if (selectedFanSpeedId > fanSpeed.length) {
                selectedFanSpeedId = 1;
              }
            });
          },
          child: AnimatedFanIcon(
            selectedFanSpeed: selectedFanSpeed,
            rotationSpeed: selectedFanSpeed.id == 1
                ? 0.0
                : selectedFanSpeed.speed,
          ),
        ),
      ],
    );
  }
}

class ClimateMode {
  final int id;
  final String icon;
  final String label;

  ClimateMode({required this.id, required this.icon, required this.label});
}
