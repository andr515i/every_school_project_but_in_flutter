import 'dart:async';
import 'dart:math';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_bloc.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_event.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallAndCupScreen extends StatefulWidget {
  const BallAndCupScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BallAndCupState();
  }
}

class BallAndCupState extends State<BallAndCupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int score = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Set the rotation duration
      vsync: this,
    );

    // BlocProvider.of<CupsAndBallBloc>(context).add(StartGame());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateButton() {
    debugPrint("should rotate..");
    _controller.forward(from: 0.0); // always start at 0
  }

  List<Offset> positions = [];

  Future<void> _shuffleCards() async {
    debugPrint("shuffling cards...");
    int counter = 0;

    Timer.periodic(
      Durations.medium4,
      (timer) {
        int firstCup = Random().nextInt(3);
        int secondCup = Random().nextInt(3);
        while (firstCup == secondCup) {
          secondCup = Random().nextInt(3);
        }
        setState(
          () {
            Offset temp = positions[firstCup];
            positions[firstCup] = positions[secondCup];
            positions[secondCup] = temp;
          },
        );
        counter++;
        if (counter == 25) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (positions.isEmpty) {
      positions = [
        // offset of left and top
        const Offset(0, 50),
        Offset(MediaQuery.of(context).size.width - 152,
            50), // width of the pictures is 152 pixels.
        Offset(
            MediaQuery.of(context).size.width / 2 - 76,
            MediaQuery.of(context).size.height -
                434), // height of the picture is 217
      ];
    }

    return BlocConsumer<CupsAndBallBloc, GameState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              width: 100,
              top: 5,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: Text(
                "Score is $score",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            AnimatedPositioned(
              top: positions[0].dy,
              left: positions[0].dx,
              curve: Curves.easeInOut,
              duration: Durations.medium1,
              child: GestureDetector(
                onTap: () => state is GameStarted
                    ? BlocProvider.of<CupsAndBallBloc>(context)
                        .add(const MakeGuess(1))
                    : debugPrint(
                        "tried to guess when it shouldnt be possible."),
                child: state is GameStarted || state is ShufflingCups
                    ? Image.asset("assets/pictures/green_cup.png")
                    : Image.asset("assets/pictures/black_cup.png"),
              ),
            ),
            AnimatedPositioned(
              left: positions[1].dx,
              top: positions[1].dy,
              curve: Curves.easeInOut,
              duration: Durations.medium1,
              child: GestureDetector(
                onTap: () => state is GameStarted
                    ? BlocProvider.of<CupsAndBallBloc>(context)
                        .add(const MakeGuess(2))
                    : debugPrint(
                        "tried to guess when it shouldnt be possible."),
                child: state is GameStarted || state is ShufflingCups
                    ? Image.asset("assets/pictures/green_cup.png")
                    : Image.asset("assets/pictures/red_cup.png"),
              ),
            ),
            AnimatedPositioned(
              top: positions[2].dy,
              left: positions[2].dx,
              curve: Curves.easeInOut,
              duration: Durations.medium1,
              child: GestureDetector(
                onTap: () => state is GameStarted
                    ? BlocProvider.of<CupsAndBallBloc>(context)
                        .add(const MakeGuess(3))
                    : debugPrint(
                        "tried to guess when it shouldnt be possible."),
                child: state is GameStarted || state is ShufflingCups
                    ? Image.asset("assets/pictures/green_cup.png")
                    : Image.asset("assets/pictures/green_cup_with_ball.png"),
              ),
            ),
            Positioned(
              // start normal game...
              width: 100,
              height: 50,
              top: MediaQuery.of(context).size.height / 2 - 100,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: GestureDetector(
                onTap: () => _rotateButton,
                child: RotationTransition(
                  turns: _controller,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CupsAndBallBloc>(context)
                          .add(StartGame());
                      BlocProvider.of<CupsAndBallBloc>(context)
                          .add(ShuffleCups());
                    },
                    child: const Icon(
                      Icons.start,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // start hard game
              width: 100,
              height: 50,
              top: MediaQuery.of(context).size.height / 2 - 100,
              left: MediaQuery.of(context).size.width / 2,
              child: GestureDetector(
                onTap: () => _rotateButton,
                child: RotationTransition(
                  turns: _controller,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CupsAndBallBloc>(context)
                          .add(StartGame());
                      int shuffleCounter = 0;
                      Timer.periodic(const Duration(seconds: 1),
                          (timer) {
                        BlocProvider.of<CupsAndBallBloc>(context)
                            .add(ShuffleCups());
                        shuffleCounter++;

                        if (shuffleCounter >= 5) {
                          timer.cancel();
                        }
                      });
                    },
                    child: const Icon(
                      Icons.start,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is ShufflingCups) {
          _shuffleCards();
          BlocProvider.of<CupsAndBallBloc>(context).add(StartGame());
        }
        if (state is GuessMade) {
          if ((state).guess) {
            // increase score
            score++;
          } else {
            // possibly reset score or decrease by one? maybe something else?
          }
          BlocProvider.of<CupsAndBallBloc>(context).add(RestartGame());
        }
      },
    );
  }
}
