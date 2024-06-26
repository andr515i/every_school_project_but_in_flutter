import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_number_event.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_state.dart';


enum RandomEvent {increment, decrement}

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  RandomNumberBloc() : super(RandomNumberState()..init()) {
    on<RandomIncrementEvent>((event, emit) => emit(state.increment(state)));
    on<RandomDecrementEvent>((event, emit) => emit(state.decrement(state)));
  }
}