import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import './spot_the_difference.dart';

class World extends ParallaxComponent<SpotTheDifference>
    with HasGameRef<SpotTheDifference> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('assets/images/background/layer-1.png'),
        ParallaxImageData('assets/images/background/layer-2.png'),
        ParallaxImageData('assets/images/background/layer-3.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
    );
  }
}
