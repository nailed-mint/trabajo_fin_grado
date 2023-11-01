import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/network_image.dart';

class ExpandedButton extends StatelessWidget {
  final String buttonText;
  final String imageUrl;
  final Function nextPage;
  final ButtonStyle style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  ExpandedButton({
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
          style: style,
          onPressed: nextPage as void Function()?,
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
