import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A StatelessWidget that displays a dialog asking the user if they want to close the application.
class CloseDialog extends StatelessWidget {
  /// Creates a new instance of CloseDialog.
  const CloseDialog({super.key});

  /// Builds the widget.
  ///
  /// Displays an AlertDialog with a title and two TextButtons. The 'No' button closes the dialog, and the 'Yes' button closes the application.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      /// The title of the dialog.
      title: const Text('¿Quieres cerrar la aplicación?'),
      actions: <Widget>[
        /// The 'No' button.
        TextButton(
          /// Closes the dialog when pressed.
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),

        /// The 'Yes' button.
        TextButton(
          /// Closes the application when pressed.
          onPressed: () => SystemNavigator.pop(),
          child: const Text('Sí'),
        ),
      ],
    );
  }
}
