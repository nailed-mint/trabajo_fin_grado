import 'package:flutter/material.dart';

/// DO NOT USE THIS FILE ON ANYTHING
///
/// While I am trying to workaround on how to separate different widgets and use
///  them as 'modules' this serves as a copy-paste-blueprint to get the
/// foundation for every menu screen.

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Optional, but recommended
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Menu(), // Other menu screen redirection goes here
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:
                              Image.asset(""), // Pictogram asset path goes here
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "", // Text at the bottom of button goes here
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // You can add more buttons here, just copy-paste the foundation above
            // and keep bloating the code ;)
          ],
        ),
      ),
    );
  }
}
