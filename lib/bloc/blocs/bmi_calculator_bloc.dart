import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/events/bmi_calculator/bmi_calculator_event.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/bmi_calculator/bmi_calculator_state.dart';

class BmiCalculatorBloc extends Bloc<BmiCalculatorEvent, BmiCalculatorState> {
  BmiCalculatorBloc() : super(BmiCalculatorState()) {
    on<WeightChangedEvent>((event, emit) {
      emit(state.copyWith(state.weight, null));
    });
    on<HeightChangedEvent>((event, emit) {
      emit(state.copyWith(null, state.height));
    });
    on((event, emit) {
      emit(state.calculateBMI(state.weight, state.height));
    });
  }
}
