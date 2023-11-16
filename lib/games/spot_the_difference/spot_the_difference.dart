import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/games/spot_the_difference/widgets/differences_image.dart';
import 'package:trabajo_fin_grado/games/spot_the_difference/widgets/score_display.dart';
import 'package:trabajo_fin_grado/games/spot_the_difference/widgets/timer.dart';

class SpotTheDifference extends StatelessWidget {
  const SpotTheDifference({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            ScoreDisplay(),
            const Timer(),
            const DifferencesImage(
              pathImageA: "assets/images/spot_the_difference/01a.jpg",
              pathImageB: "assets/images/spot_the_difference/01b.jpg",
            ),
            //TODO: Add finish button
          ],
        ),
      ),
    );
  }
}
