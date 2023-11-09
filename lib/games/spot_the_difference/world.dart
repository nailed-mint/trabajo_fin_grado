import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import './spot_the_difference.dart';

/// A ParallaxComponent for the SpotTheDifference game.
///
/// This component creates a parallax effect using three layers of images.
class World extends ParallaxComponent<SpotTheDifference>
    with HasGameRef<SpotTheDifference> {
  /// Loads the parallax images and sets up the parallax effect.
  ///
  /// This method is called when the component is added to the game.
  @override
  Future<void> onLoad() async {
    /// The parallax effect is created using three images.
    /// The images are loaded from the 'background' directory.
    /// The size of the parallax is set to 1920x1080
    /// and the fill mode is set to 'height'.
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
