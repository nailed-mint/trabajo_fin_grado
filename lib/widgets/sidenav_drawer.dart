import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/data_list.dart';
import 'package:trabajo_fin_grado/screens/game_selector.dart';
import 'package:trabajo_fin_grado/screens/welcome.dart';

class SidenavDrawer extends StatelessWidget {
  const SidenavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return sidenavDrawer(context);
  }

  Drawer sidenavDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Image(
              image: AssetImage('assets/img/125x53-unnido_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: const Text("Menú principal"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Selector de juego"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameSelector(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Visualización de datos"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
