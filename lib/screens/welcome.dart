import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/about_dialog.dart';
import 'package:trabajo_fin_grado/widgets/sidenav_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const SidenavDrawer(),
        appBar: AppBar(
          title: const Text("Bienvenid@ a UnNido"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const About(),
                );
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        body: const Text(
          "PANTALLA DE BIENVENIDA INICIAL, DECORACIÓN EN PROCESO",
        ),
      );
}
