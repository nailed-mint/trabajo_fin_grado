import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) => aboutDialog(context);

  AlertDialog aboutDialog(BuildContext context) => AlertDialog(
        title: const Text("Sobre esta app"),
        content: const SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Esta aplicación ha sido desarrollada por Daniel Montealegre Claramonte para su Trabajo de Fin de Grado en Ingeniería Informática con la Universidad de Castilla-La Mancha",
                textAlign: TextAlign.justify,
              ),
              Image(
                image: AssetImage(
                  "assets/img/567x354-uclm_logo.png",
                ),
                fit: BoxFit.contain,
                width: double.maxFinite,
              ),
              Text(
                "Para el desarrollo de esta aplicación se ha contado con la colaboración de las profesionales de Centro UnNido: Infancia y Familia",
                textAlign: TextAlign.justify,
              ),
              Image(
                image: AssetImage(
                  "assets/img/125x53-unnido_logo.png",
                ),
                fit: BoxFit.contain,
                width: double.maxFinite,
              ),
              Text(
                "Los símbolos pictográficos utilizados en esta aplicación son propiedad del Gobierno de Aragón y han sido creados por Sergio Palao para ARASAAC (http://arasaac.org), que los distribuye bajo licencia Creative Commons (BY-NC-SA).",
                textAlign: TextAlign.justify,
              ),
              Image(
                image: AssetImage(
                  "assets/img/2083x495-arasaac_logo.png",
                ),
                fit: BoxFit.contain,
                width: double.maxFinite,
              ),
              Text(
                "Algunas imágenes utilizadas en esta aplicación han sido diseñadas por Freepik (https://www.freepik.com).",
                textAlign: TextAlign.justify,
              ),
              Image(
                image: AssetImage(
                  "assets/img/939x338-freepik_logo.png",
                ),
                fit: BoxFit.contain,
                width: double.maxFinite,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Volver"),
          ),
        ],
      );
}
