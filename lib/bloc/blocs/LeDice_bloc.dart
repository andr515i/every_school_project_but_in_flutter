import 'dart:math';

import 'package:every_school_project_but_in_flutter/bloc/events/LeDice/DiceThrowEvent.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/LeDice/LeDice_State.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeDiceBloc extends Bloc<LeDiceThrowInterface, LeDiceState> {
  LeDiceBloc() : super(LeDiceState()) {
    on<LeDiceThrowEvent>((event, emit) {
      int newDiceNumber = Random().nextInt(6) + 1;
      Color newColor = Colors.white;
      switch (newDiceNumber) {
        case 1:
          newColor = Colors.black;
          break;
        case 2:
          newColor = Colors.orange;
          break;
        case 3:
          newColor = Colors.yellow;
          break;
        case 4:
          newColor = Colors.greenAccent;
          break;
        case 5:
          newColor = Colors.blueGrey;
          break;
        case 6:
          newColor = Colors.red;
          break;
        default:
          break;
      }
      emit(state.copyWith(color: newColor, currentDiceNumber: newDiceNumber));
    });
  }
}
