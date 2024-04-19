import 'package:bloc/bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/events/cups_and_ball/cups_and_ball_event.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/cups_and_ball/cups_and_ball_state.dart';

class CupsAndBallBloc extends Bloc<CupsAndBallEvent, CupsAndBallState> {
  CupsAndBallBloc() : super(CupsAndBallState()) {
    on<GuessCupEvent>((event, emit) {});
    on<ShuffleCupsEvent>((event, emit) {});
  }
}
