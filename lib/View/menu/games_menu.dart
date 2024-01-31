import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/View/games/spot_the_difference_game.dart';

class GamesMenu extends StatelessWidget {
  const GamesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elige tu perfil"),
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
                      builder: (context) =>
                          const SpotTheDifference(), // FIXME: change to spot the difference game
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/images/pictograms/difference.png",
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Encuentra las diferencias",
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
