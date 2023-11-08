import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import './spot_the_difference.dart';

class World extends ParallaxComponent<SpotTheDifference>
    with HasGameRef<SpotTheDifference> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('background/layer-1.png'),
        ParallaxImageData('background/layer-2.png'),
        ParallaxImageData('background/layer-3.png'),
      ],
      fill: LayerFill.height,
      size: Vector2(1920, 1080),
    );
  }
}
