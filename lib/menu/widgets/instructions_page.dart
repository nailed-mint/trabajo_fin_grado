import 'package:flutter/material.dart';

/// A StatelessWidget that displays a dialog with instructions.
class InstructionsPage extends StatelessWidget {
  /// Creates a new instance of InstructionsPage.
  const InstructionsPage({super.key});

  /// Builds the widget.
  ///
  /// Displays a dialog with a title and a body of text. The dialog also includes an ElevatedButton.
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// The title of the dialog.
            const Text(
              "INSTRUCCIONES AQUI",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// The body of the dialog.
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, sapien vel bibendum bibendum, elit sapien bibendum sapien, vel bibendum sapien elit vel sapien. Sed euismod, sapien vel bibendum bibendum, elit sapien bibendum sapien, vel bibendum sapien elit vel sapien.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            /// An ElevatedButton that can be used to close the dialog or perform another action.
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cerrar"),
            ),
          ],
        ),
      ),
    );
  }
}
