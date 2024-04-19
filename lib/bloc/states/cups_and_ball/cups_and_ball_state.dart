class CupsAndBallState {
  final int amountOfPictures;
  final int guess;
  final bool isLoading;
  CupsAndBallState(
      {this.amountOfPictures = 3, this.guess = 0, this.isLoading = false});

  CupsAndBallState copyWith(
      {int? amountOfPictures, int? guess, bool? isLoading}) {
    return CupsAndBallState(
        amountOfPictures: amountOfPictures ?? this.amountOfPictures,
        guess: guess ?? this.guess,
        isLoading: isLoading ?? this.isLoading);
  }

  CupsAndBallState guessCup(int guess) {
    if (guess <= amountOfPictures && guess > 0) {
      return copyWith(guess: guess);
    }
    return copyWith();
  }
}
