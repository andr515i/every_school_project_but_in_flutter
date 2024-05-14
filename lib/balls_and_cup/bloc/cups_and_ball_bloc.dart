import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_event.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_state.dart';
import 'package:flutter/material.dart';

class CupsAndBallBloc extends Bloc<GameEvent, GameState> {
  CupsAndBallBloc() : super(GameInitial()) {
    bool gameStarted = false;
    on<StartGame>((event, emit) {
      debugPrint("StartGameEvent");
      gameStarted = true;
      int initialPosition = 3;
      emit(GameStarted(initialPosition));
    });
    on<ShuffleCups>((event, emit) {
      debugPrint("ShuffleCardsEvent");
      if (gameStarted) {
        debugPrint("now shuffling cards...");
        emit(ShufflingCups());
      } else {
        debugPrint("cards finished shuffling...");
        emit(CupsShuffled());
      }
    });
    on<MakeGuess>((event, emit) {
      debugPrint("MakeGuessEvent");
      debugPrint('guess: ${event.guessedPosition}');
      if (gameStarted) {
        bool isCorrect = (state as GameStarted).ballPosition == event.guessedPosition;
        debugPrint("guess made is $isCorrect");
        emit(GuessMade(isCorrect));
      }
    });
    on<RestartGame>((event, emit) {
      debugPrint("RestartGameEvent");

      emit(GameInitial());
    });
  }
}
