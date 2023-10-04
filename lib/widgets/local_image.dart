import 'package:flutter/material.dart';

class LocalImage extends StatelessWidget {
  const LocalImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }

}