import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../spot_the_difference.dart';

/// A Component for the SpotTheDifference game that manages the game state and score.
class GameManager extends Component with HasGameRef<SpotTheDifference> {
  /// Creates a new instance of GameManager.
  GameManager();

  /// The score of the game.
  ///
  /// This is a ValueNotifier that notifies its listeners when the score changes.
  ValueNotifier<int> score = ValueNotifier(0);

  /// The state of the game.
  GameState state = GameState.intro;

  /// Returns whether the game is in the playing state.
  bool get isPlaying => state == GameState.playing;

  /// Returns whether the game is in the game over state.
  bool get isGameOver => state == GameState.gameOver;

  /// Returns whether the game is in the intro state.
  bool get isIntro => state == GameState.intro;

  /// Resets the game.
  ///
  /// This method sets the score to 0 and the game state to intro.
  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  /// Increases the score by 1.
  void increaseScore() {
    score.value++;
  }
}

/// An enumeration of the possible game states.
enum GameState { intro, playing, gameOver }
