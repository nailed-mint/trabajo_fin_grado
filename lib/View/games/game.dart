import 'package:flutter/material.dart';

import 'package:trabajo_fin_grado/View/games/spot_the_difference/spot_the_difference.dart';
import 'package:trabajo_fin_grado/View/games/widgets/exit_button.dart';
import 'package:trabajo_fin_grado/View/games/widgets/score_display.dart';
import 'package:trabajo_fin_grado/View/games/widgets/time_spent_card.dart';

class Game extends StatelessWidget {
  final GlobalKey<ScoreDisplayState> scoreDisplayKey = GlobalKey();
  final GlobalKey<TimeSpentCardState> timeSpentCardKey = GlobalKey();
  final String gameName;
  late final TimeSpentCard timeSpentCard;
  late final ScoreDisplay scoreDisplay;

  Game({super.key, required this.gameName}) {
    timeSpentCard = TimeSpentCard(key: timeSpentCardKey);

    scoreDisplay = ScoreDisplay(
      key: scoreDisplayKey,
      timeSpentCardState: timeSpentCardKey.currentState!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function()> games = {
      "Spot The Difference": () => spotTheDifference(
            context: context,
            scoreDisplayState: scoreDisplayKey.currentState,
          ),
    };

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: exitButton(context)),
                Expanded(child: scoreDisplay),
                Expanded(child: timeSpentCard),
              ],
            ),
            if (games[gameName] != null) games[gameName]!(),
          ],
        ),
      ),
    );
  }
}
