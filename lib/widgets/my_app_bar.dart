import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  final Widget title; // Fields in a Widget subclass are always "final"

  @override
  /// Creates a Container with a height of 56 device-independent pixels with an
  /// internal padding of 8 pixels, both on the left and the right. Inside the
  /// container, MyAppBar uses a Row layout to organize its children. The middle
  /// child, the title widget, is marked as Expanded, which means it expands to
  /// fill any remaining available space that hasn’t been consumed by the other
  /// children. You can have multiple Expanded children and determine the ratio
  /// in which they consume the available space using the flex argument to
  /// Expanded.
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.indigo),
      child: Row(
        children: [
          const IconButton(
              onPressed: null,
              tooltip: "Navigation menu",
              icon: Icon(Icons.menu)),
          Expanded(child: title),
          const IconButton(
              onPressed: null, tooltip: "Search", icon: Icon(Icons.search)
          )
        ],
      ),
    );
  }
}
