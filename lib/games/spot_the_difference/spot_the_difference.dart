import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';
import 'managers/managers.dart';

/// The SpotTheDifference game.
///
/// This class extends FlameGame and mixes in
/// HasKeyboardHandlerComponents and HasCollisionDetection.
class SpotTheDifference extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  /// Creates a new instance of SpotTheDifference.
  SpotTheDifference({super.children});

  /// The World component of the game.
  final World _world = World();

  /// The GameManager of the game.
  GameManager gameManager = GameManager();

  /// Loads the game components and sets up the game.
  ///
  /// This method is called when the game is loaded.
  @override
  Future<void> onLoad() async {
    /// Adds the World component to the game.
    await add(_world);

    /// Adds the GameManager to the game.
    await add(gameManager);

    /// resets the game.
    reset();

    /// Adds the game overlay to the game.
    overlays.add('gameOverlay');
  }

  @override
  void update(double dt) {
    /// Calls the super implementation of update.
    super.update(dt);

    /// If the game is over, no further updates are made.
    if (gameManager.isGameOver) {
      return;
    }

    /// If the game is in the intro state, the intro overlay is added.
    if (gameManager.isIntro) {
      overlays.add('introOverlay');
      return;
    }

    /// If the game is playing, the game logic is executed.
    if (gameManager.isPlaying) {
      // TODO: add game logic
    }
  }

  /// Returns the background color of the game.
  @override
  Color backgroundColor() => Colors.white;

  /// Initializes the game.
  ///
  /// This method is called to reset the game manager.
  void initialize() {
    gameManager.reset();
  }

  /// Starts the game.
  ///
  /// This method is called to initialize the game and set the game state to playing.
  /// It also removes the intro overlay.
  void start() {
    initialize();
    gameManager.state = GameState.playing;
    overlays.remove('introOverlay');
  }

  /// Resets the game.
  ///
  /// This method is called to reset the game manager and remove the score overlay.
  void reset() {
    gameManager.reset();
    overlays.remove('scoreOverlay');
  }

  /// Handles the win condition of the game.
  ///
  /// This method is called when the player wins the game.
  /// It sets the game state to game over and adds the score overlay.
  void onWin() {
    gameManager.state = GameState.gameOver;
    overlays.add('scoreOverlay');
  }

  /// Toggles the pause state of the game.
  ///
  /// This method is called to pause or resume the game engine.
  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }
}
