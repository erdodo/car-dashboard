import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menulist extends StatefulWidget {
  const Menulist({super.key, required this.menuList, this.onSelected});

  final List<IGlobalList> menuList;
  final onSelected;

  @override
  State<Menulist> createState() => _MenulistState();
}

class _MenulistState extends State<Menulist> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.menuList.map((menuItem) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: (){
              if (widget.onSelected != null) {
                widget.onSelected!(menuItem.id);
              }
            },
            child: menuItem.onlyIcon
                ? menuItem.iconSvg != null
                      ? SvgPicture.asset(
                          menuItem.iconSvg,
                          width: 30,
                          height: 30,
                          colorFilter: ColorFilter.mode(
                            menuItem.color,
                            BlendMode.srcIn,
                          ),
                        )
                      : Icon(menuItem.icon)
                : Text(
                    menuItem.label,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        );
      }).toList(),
    );
  }
}

class IGlobalList {
  int id;
  String label;
  Color color;
  IconData? icon;
  bool onlyIcon = false;
  String iconSvg = "";
  IGlobalList({
    required this.id,
    required this.label,
    required this.color,
    this.icon,
    this.onlyIcon = false,
    this.iconSvg = "",
  });
}
