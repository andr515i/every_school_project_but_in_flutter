import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState();
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameStarted extends GameState {
  final int ballPosition;
  const GameStarted(this.ballPosition);
}

class CupsShuffled extends GameState {} // shuffle done

class ShufflingCups extends GameState {} // currently shuffling.

class GuessMade extends GameState {
  final bool isCorrect;
  const GuessMade(this.isCorrect);
}
