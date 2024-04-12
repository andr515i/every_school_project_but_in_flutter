import 'package:meta/meta.dart';

@immutable
abstract class BmiCalculatorEvent {}

class WeightChangedEvent extends BmiCalculateEvent {
  final double weight;
  WeightChangedEvent({required this.weight});
}

class HeightChangedEvent extends BmiCalculateEvent {
  final double height;
  HeightChangedEvent({required this.height});
}

class BmiCalculateEvent extends BmiCalculatorEvent {}


class BmiFormSubmitEvent extends BmiCalculateEvent {}