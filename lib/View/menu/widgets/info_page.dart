import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "CRÉDITOS",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "ARASAAC",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Los símbolos pictográficos utilizados en esta aplicación son propiedad del Gobierno de Aragón y han sido creados por Sergio Palao para ARASAAC (http://arasaac.org), que los distribuye bajo licencia Creative Commons (BY-NC-SA).",
                textAlign: TextAlign.justify,
              ),
              const Image(
                image: AssetImage("assets/images/logo/arasaac.png"),
              ),
              const SizedBox(height: 16),
              const Text(
                "FREEPIK",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Las imágenes utilizadas en el juego \"Encuentra las diferencias\" han sido diseñadas por Freepik (https://www.freepik.com).",
                textAlign: TextAlign.justify,
              ),
              const Image(
                image: AssetImage(
                  "assets/images/logo/freepik.png",
                ),
              ),
              const SizedBox(height: 16),
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
