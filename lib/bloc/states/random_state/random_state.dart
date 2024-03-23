import 'dart:math';

class RandomNumberState {
  late int _currentNumber = 0;
  late int _randomNumber = 0;
  int get currentValue => _currentNumber;

  /// reset everything
  RandomNumberState init() {
    return RandomNumberState()
      .._currentNumber = 0
      .._randomNumber = 0;
  }

  /// returns the counter with +1
  RandomNumberState increment(RandomNumberState currentState) {
    return RandomNumberState()
      .._randomNumber = Random().nextInt(101)
      .._currentNumber = currentState.currentValue
      .._currentNumber = min((_currentNumber + _randomNumber), 100);
  }

  /// returns the counter with -1
  RandomNumberState decrement(RandomNumberState currentState) {
    return RandomNumberState()
      .._randomNumber = Random().nextInt(currentState.currentValue + 1)
      .._currentNumber = currentState.currentValue
      .._currentNumber = max((_currentNumber - _randomNumber), 0);
  }

}
