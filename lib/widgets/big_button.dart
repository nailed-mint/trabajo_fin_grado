import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:trabajo_fin_grado/widgets/network_image.dart';

class BigButton extends StatelessWidget {
  final String buttonText;
  final String imageUrl;
  final Widget nextPage;

  const BigButton({
    super.key,
    required this.buttonText,
    required this.imageUrl,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: NetImage(imageUrl: imageUrl),
                ),
                const SizedBox(height: 10),
                Text(
                  buttonText,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
