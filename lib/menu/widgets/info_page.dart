import 'package:flutter/material.dart';

/// A StatelessWidget that displays a dialog with credits information.
class InfoPage extends StatelessWidget {
  /// Creates a new instance of InfoPage.
  const InfoPage({super.key});

  /// Builds the widget.
  ///
  /// Displays a dialog with a title and a list of credits. The dialog is scrollable to accommodate a large amount of content.
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// The title of the dialog.
              const Text(
                "CRÉDITOS",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              //ARASAAC
              /// The title for the ARASAAC section.
              const Text(
                "ARASAAC",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              /// A text description about the use of ARASAAC images in the application.
              const Text(
                "Los símbolos pictográficos utilizados en esta aplicación son propiedad del Gobierno de Aragón y han sido creados por Sergio Palao para ARASAAC (http://arasaac.org), que los distribuye bajo licencia Creative Commons (BY-NC-SA).",
                textAlign: TextAlign.justify,
              ),

              /// Displaying the ARASAAC logo.
              const Image(
                image: AssetImage("assets/images/logo/arasaac.png"),
              ),

              /// Providing some space between the ARASAAC section and the next section.
              const SizedBox(height: 16),

              //FREEPIK
              /// The title for the Freepik section.
              const Text(
                "FREEPIK",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              /// A text description about the use of Freepik images in the application.
              const Text(
                "Las imágenes utilizadas en el juego \"Encuentra las diferencias\" han sido diseñadas por Freepik (https://www.freepik.com).",
                textAlign: TextAlign.justify,
              ),

              /// Displaying the Freepik logo.
              const Image(
                image: AssetImage(
                  "assets/images/logo/freepik.png",
                ),
              ),

              /// Providing some space between the FREEPIK section and the next section.
              const SizedBox(height: 16),

              //CLOSE BUTTON
              /// An ElevatedButton that can be used to close the dialog.
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
