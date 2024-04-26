import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/Bmi_calculator/bloc/bmi_calculator_event.dart';
import 'package:every_school_project_but_in_flutter/Bmi_calculator/bloc/bmi_calculator_state.dart';
import 'package:flutter/material.dart';

class BmiCalculatorBloc extends Bloc<BmiCalculatorEvent, BmiCalculatorState> {
  BmiCalculatorBloc() : super(BmiCalculatorState()) {
    on<WeightChangedEvent>((event, emit) {
      debugPrint("weight: ${state.weight}, height: ${state.height}");
      emit(state.copyWith(weight: event.weight));
    });
    on<HeightChangedEvent>((event, emit) {
      debugPrint("weight: ${state.weight}, height: ${state.height}");
      emit(state.copyWith(height: event.height));
    });
    on<BmiFormSubmitEvent>((event, emit) {
      debugPrint("weight: ${state.weight}, height: ${state.height}");
      emit(state.copyWith(bmi: (state.weight * 10000/ (state.height * state.height)))); // dont question it
    });
  }
}
