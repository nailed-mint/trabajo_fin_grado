import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/games/spot_the_difference/widgets/invisible_button.dart';

class DifferencesImage extends StatelessWidget {
  /// Constructor: DifferencesImage
  const DifferencesImage(
      {super.key, required this.pathImageA, required this.pathImageB});

  final String pathImageA, pathImageB;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  pathImageA,
                  width: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 100,
                left: 50,
                child: InvisibleButton(),
              ),
              const Positioned(
                top: 95,
                left: 185,
                child: InvisibleButton(),
              ),
              const Positioned(
                top: 65,
                left: 160,
                child: InvisibleButton(),
              ),
              const Positioned(
                top: 25,
                left: 110,
                child: InvisibleButton(),
              ),
              const Positioned(
                top: 50,
                left: 215,
                child: InvisibleButton(),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  pathImageB,
                  width: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const Text("ENCUENTRA LAS DIFERENCIAS"),
        ],
      ),
    );
  }
}
