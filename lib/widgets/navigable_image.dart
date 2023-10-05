import 'package:flutter/material.dart';

class NavigableImage extends StatelessWidget {
  const NavigableImage({required this.clickDestination, super.key});

  final Widget clickDestination;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 340,
      child: Card(
        elevation: 6,
        color: Colors.blue.shade100,
        semanticContainer: true,
        // Implement InkResponse
        child: InkResponse(
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => clickDestination),
            );
          },
          // Add image & text
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ink.image(
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  image: const AssetImage(
                      'assets/jugar_con_el_tablet.png')),
              const Text(
                'Jugar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

}