import 'package:equatable/equatable.dart';

abstract class IBmiCalculatorState extends Equatable {
  @override
  List<Object> get props => [];
}

class BmiCalculatorState extends IBmiCalculatorState {
  final double weight;
  final double height;
  final double bmi;
  BmiCalculatorState({this.height = 0, this.weight = 0, this.bmi = 0});

  BmiCalculatorState copyWith(double? weight, double? height) {
    return BmiCalculatorState(
        height: height ?? this.height, weight: weight ?? this.weight);
  }

  BmiCalculatorState calculateBMI(double weight, double height) {
    return BmiCalculatorState(bmi: (weight / (height * height)));
  }
}
