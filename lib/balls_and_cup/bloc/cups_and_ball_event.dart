import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
  @override
  List<Object> get props => [];
}

class StartGame extends GameEvent{}

class ShuffleCards extends GameEvent{

}

class MakeGuess extends GameEvent{
  final int guessedPosition;
  const MakeGuess(this.guessedPosition);
}

class RestartGame extends GameEvent{}
