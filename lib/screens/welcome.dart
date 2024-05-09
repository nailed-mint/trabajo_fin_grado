import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/data_list.dart';
import 'package:trabajo_fin_grado/screens/game_selector.dart';
import 'package:trabajo_fin_grado/services/arasaac_service.dart';
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
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/img/125x53-unnido_logo.png',
                  fit: BoxFit.contain, width: 500),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameSelector(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set this to the desired value
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Text("Elegir un juego"),
                            ArasaacService.getPictogram(
                              icon: 29151,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DataList(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set this to the desired value
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const Text("Visualizar datos"),
                            ArasaacService.getPictogram(
                              icon: 35645,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
