import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LeDiceStateInterface extends Equatable {}

class LeDiceState {
  final int currentDiceNumber;
  final Color color;

  LeDiceState({this.color = Colors.white, this.currentDiceNumber = 0});

  LeDiceState copyWith({Color? color, int? currentDiceNumber}) {
    return LeDiceState(
        color: color ?? this.color,
        currentDiceNumber: currentDiceNumber ?? this.currentDiceNumber);
  }
}
