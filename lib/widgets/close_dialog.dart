import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

class CloseDialog extends StatelessWidget {
  const CloseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Quieres cerrar la aplicación?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('Sí'),
        ),
      ],
    );
  }
}
