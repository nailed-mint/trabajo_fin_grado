import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';
import 'managers/managers.dart';

class SpotTheDifference extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  SpotTheDifference({super.children});

  final World _world = World();
  GameManager gameManager = GameManager();

  @override
  Future<void> onLoad() async {
    await add(_world);
    await add(gameManager);

    overlays.add('gameOverlay');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isIntro) {
      overlays.add('introOverlay');
      return;
    }

    if (gameManager.isPlaying) {
      // TODO: add game logic
    }
  }

  @override
  Color backgroundColor() => Colors.white;

  void initialize() {
    gameManager.reset();
  }

  void start() {
    initialize();
    gameManager.state = GameState.playing;
    overlays.remove('introOverlay');
  }

  void reset() {
    gameManager.reset();
    overlays.remove('scoreOverlay');
  }

  void onWin() {
    gameManager.state = GameState.gameOver;
    overlays.add('scoreOverlay');
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }
}
