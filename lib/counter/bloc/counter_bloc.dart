import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/counter_change_event.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/counter_change_state.dart';


enum CounterEvent {increment, decrement}

class CounterChangeBloc extends Bloc<CounterChangeEvent, CounterChangeState> {
  CounterChangeBloc() : super(CounterChangeState()..init()) {
    on<CounterIncrementEvent>((event, emit) => emit(state.increment(state)));
    on<CounterDecrementEvent>((event, emit) => emit(state.decrement(state)));
  }
}