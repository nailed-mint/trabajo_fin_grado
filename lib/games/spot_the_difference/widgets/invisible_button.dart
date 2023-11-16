import 'package:flutter/material.dart';

class InvisibleButton extends StatefulWidget {
  const InvisibleButton({super.key});

  @override
  InvisibleButtonState createState() => InvisibleButtonState();
}

class InvisibleButtonState extends State<InvisibleButton> {
  Color color = Colors.transparent;

  void onPressed() {
    setState(() {
      color = Colors.red;
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
