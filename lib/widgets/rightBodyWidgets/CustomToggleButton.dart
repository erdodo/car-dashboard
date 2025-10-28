import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({super.key, required this.isOn, required this.label, this.onPressed, required this.icon});

  final bool isOn;
  final String label;
  final String icon;
  final VoidCallback? onPressed;

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    var buttonWidth = MediaQuery.of(context).size.width * 0.05;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
          Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: widget.isOn ? Colors.cyan : Colors.grey.shade700,
              width: 2.0,
            ),
          )
      ),

      onPressed: widget.onPressed,
      child: Column(
        children: [
          SvgPicture.asset(
            widget.icon,
            width: buttonWidth,
            height: buttonWidth,
            colorFilter: ColorFilter.mode(
              widget.isOn ? Colors.cyan: Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}