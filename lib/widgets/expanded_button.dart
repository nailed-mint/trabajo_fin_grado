import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/network_image.dart';

/// A StatelessWidget that displays an expanded button with an image and text.
class ExpandedButton extends StatelessWidget {
  /// The text to be displayed on the button.
  final String buttonText;

  /// The URL of the image to be displayed on the button.
  final String imageUrl;

  /// The function to be executed when the button is pressed.
  final Function nextPage;

  /// The style of the button.
  final ButtonStyle style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  /// Creates a new instance of ExpandedButton.
  ///
  /// Requires the button text, image URL, and next page function as parameters.
  ExpandedButton({
    super.key,
    required this.buttonText,
    required this.imageUrl,
    required this.nextPage,
  });

  /// Builds the widget.
  ///
  /// Displays an expanded button with an image and text. The button executes the next page function when pressed.
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
                /// The image displayed on the button.
                Expanded(
                  child: NetImage(imageUrl: imageUrl),
                ),

                /// Providing some space between the image and the text.
                const SizedBox(height: 10),

                /// The text displayed on the button.
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
