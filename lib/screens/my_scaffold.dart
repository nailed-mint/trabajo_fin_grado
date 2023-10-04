import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/local_image.dart';

import '../widgets/my_app_bar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  /// Organizes its children in a vertical column. At the top of the column it
  /// places an instance of MyAppBar, passing the app bar a Text widget to use
  /// as its title. Passing widgets as arguments to other widgets is a powerful
  /// technique that lets you create generic widgets that can be reused in a
  /// wide variety of ways. Finally, MyScaffold uses an Expanded to fill the
  /// remaining space with its body, which consists of a centered message.
  Widget build(BuildContext context) {
    //Material is an abstract piece of paper on which UI appears
    return Material(
      child: Column(
        children: [
          MyAppBar(title: Text(
            "My App Bar",
            style: Theme.of(context).primaryTextTheme.titleLarge,
          )
          ),
          const Expanded(child: Center(
            child: Text("Hola Mundo"),
          )
          ),
          LocalImage(path: 'assets/jugar_con_el_tablet.png'),
        ],
      ),
    );
  }
}