import 'package:flutter/material.dart';

class InvisibleButton extends StatefulWidget {
  final VoidCallback onButtonPressed;

  const InvisibleButton({super.key, required this.onButtonPressed});

  @override
  InvisibleButtonState createState() => InvisibleButtonState();
}

class InvisibleButtonState extends State<InvisibleButton> {
  Color color = Colors.transparent;
  bool hasBeenPressed = false;

  void onPressed() {
    setState(() {
      if (!hasBeenPressed) {
        widget.onButtonPressed();
        color = Colors.red;
        hasBeenPressed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
