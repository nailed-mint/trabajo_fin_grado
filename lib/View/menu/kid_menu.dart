import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/View/menu/games_menu.dart';

class KidMenu extends StatelessWidget {
  const KidMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¿Qué quieres hacer?"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GamesMenu(),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/images/pictograms/play.png",
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Jugar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // You can add more buttons here
          ],
        ),
      ),
    );
  }
}
