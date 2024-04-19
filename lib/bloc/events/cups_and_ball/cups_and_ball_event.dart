abstract class CupsAndBallEvent {}

class GuessCupEvent extends CupsAndBallEvent {
  final int guess;

  GuessCupEvent({required this.guess});
}

class ShuffleCupsEvent extends CupsAndBallEvent {}
