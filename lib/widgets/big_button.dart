import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final Widget nextPage;

  const BigButton({
    super.key,
    required this.buttonText,
    required this.imagePath,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 10),
          Text(buttonText),
        ],
      ),
    );
  }
}
