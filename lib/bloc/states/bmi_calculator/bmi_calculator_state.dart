import 'package:equatable/equatable.dart';

abstract class IBmiCalculatorState extends Equatable {}

class BmiCalculatorState extends IBmiCalculatorState {
  final double weight;
  final double height;
  final double bmi;
  BmiCalculatorState({this.height = 0, this.weight = 0, this.bmi = 0});

  @override
  List<Object?> get props => [weight, height, bmi];

  BmiCalculatorState copyWith({double? weight, double? height, double? bmi}) {
    return BmiCalculatorState(
        height: height ?? this.height,
        weight: weight ?? this.weight,
        bmi: bmi ?? this.bmi);
  }
}
