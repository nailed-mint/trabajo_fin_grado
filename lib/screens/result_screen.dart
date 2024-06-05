import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/screens/data_list.dart';
import 'package:trabajo_fin_grado/screens/game_selector.dart';
import 'package:trabajo_fin_grado/screens/welcome.dart';
import 'package:trabajo_fin_grado/services/arasaac_service.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Partida completada"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize:
                Size.fromHeight(50.0), // Provide the preferred height.
            child: Text("¡Enhorabuena!"),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
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
                  Navigator.pushReplacement(
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
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                  (Route<dynamic> route) => false,
                ),
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
                      const Text("Regresar al inicio"),
                      ArasaacService.getPictogram(
                        icon: 9861,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
