import 'package:flutter/material.dart';

import 'package:trabajo_fin_grado/screens/my_scaffold.dart';

void main() {
  /// Takes the given Widget and makes it the root of the widget tree.
  ///
  /// The framework forces the root widget to cover the screen
  runApp(
    const MaterialApp(
      title: "My app", // title used by OS's Task Switcher
      home: SafeArea(child: MyScaffold()),
    )
  );
}

