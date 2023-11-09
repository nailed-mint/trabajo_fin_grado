import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../spot_the_difference.dart';

// Overlay that shows the intro screen
class IntroOverlay extends StatefulWidget {
  const IntroOverlay(this.game, {super.key});

  final Game game;

  @override
  State<IntroOverlay> createState() => _IntroOverlayState();
}

class _IntroOverlayState extends State<IntroOverlay> {
  @override
  Widget build(BuildContext context) {
    SpotTheDifference game = widget.game as SpotTheDifference;

    return LayoutBuilder(
      builder: (context, constraints) {
        final TextStyle titleStyle = (constraints.maxWidth > 500)
            ? Theme.of(context).textTheme.displayLarge!
            : Theme.of(context).textTheme.displaySmall!;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Spot the difference",
                    style: titleStyle.copyWith(
                      height: 8,
                    ),
                  ),
                  Text(
                    "Find the differences between the two images",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const WhiteSpace(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        game.start();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(100, 50),
                        ),
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      child: const Text("Start"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
