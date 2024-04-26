import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_event.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_state.dart';
import 'package:flutter/material.dart';

class CupsAndBallBloc extends Bloc<GameEvent, GameState> {
  CupsAndBallBloc() : super(GameInitial()) {
    int counter = -1;
    bool gameStarted = false;
    on<StartGame>((event, emit) {
      gameStarted = true;
      int initialPosition = Random().nextInt(3);
      emit(GameStarted(initialPosition));
    });
    on<ShuffleCards>((event, emit) {
      counter++;
      debugPrint("ShuffleCardsEvent... counter: $counter");
      if (counter % 25 ==  0 && gameStarted) {
        debugPrint("now shuffling cards...");
        emit(ShufflingCups());
      } else {
        debugPrint("cards finished shuffling...");
        emit(CupsShuffled());
      }
    });
    on<MakeGuess>((event, emit) {
      debugPrint('guess: ${event.guessedPosition}');
      if (state is GameStarted) {
        bool isCorrect =
            (state as GameStarted).ballPosition == event.guessedPosition;
        emit(GuessMade(isCorrect));
      }
    });
    on<RestartGame>((event, emit) {
      emit(GameInitial());
    });
  }
}
