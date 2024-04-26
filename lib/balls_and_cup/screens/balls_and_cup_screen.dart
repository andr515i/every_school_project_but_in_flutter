import 'dart:async';
import 'dart:math';

import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_bloc.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_event.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallAndCupScreen extends StatefulWidget {
  const BallAndCupScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BallAndCupState();
  }
}

class BallAndCupState extends State<BallAndCupScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Offset> positions = [];

  Future<void> _ShuffleCards() async {
    debugPrint("shuffling cards...");
    int counter = 0;
    Timer.periodic(Durations.medium4, (timer) {
      int firstCup = Random().nextInt(3);
      int secondCup = Random().nextInt(3);
      while (firstCup == secondCup) {
        secondCup = Random().nextInt(3);
      }
      setState(() {
        Offset temp = positions[firstCup];
        positions[firstCup] = positions[secondCup];
        positions[secondCup] = temp;
      });
      counter++;
      if (counter == 25) {
        timer.cancel();
      }
    });
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

    return BlocConsumer<CupsAndBallBloc, GameState>(builder: (context, state) {
      return Stack(
        children: [
          AnimatedPositioned(
            top: positions[0].dy,
            left: positions[0].dx,
            curve: Curves.easeInOut,
            duration: Durations.medium1,
            child: GestureDetector(
              onTap: () => BlocProvider.of<CupsAndBallBloc>(context)
                  .add(const MakeGuess(1)),
              child: Image.asset("assets/pictures/black_cup.png"),
            ),
          ),
          AnimatedPositioned(
            left: positions[1].dx,
            top: positions[1].dy,
            curve: Curves.easeInOut,
            duration: Durations.medium1,
            child: GestureDetector(
                onTap: () => BlocProvider.of<CupsAndBallBloc>(context)
                    .add(const MakeGuess(2)),
                child: Image.asset("assets/pictures/green_cup.png")),
          ),
          AnimatedPositioned(
            top: positions[2].dy,
            left: positions[2].dx,
            curve: Curves.easeInOut,
            duration: Durations.medium1,
            child: GestureDetector(
              onTap: () => BlocProvider.of<CupsAndBallBloc>(context)
                  .add(const MakeGuess(3)),
              child: Image.asset("assets/pictures/red_cup.png"),
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                BlocProvider.of<CupsAndBallBloc>(context).add(ShuffleCards()),
            child: const Icon(Icons.radio_button_checked),
          ),
        ],
      );
    }, listener: (context, state) {
      if (state is ShufflingCups) {
        _ShuffleCards();
        BlocProvider.of<CupsAndBallBloc>(context).add(ShuffleCards());
      } 
      if (state is GuessMade) {
        
      }
    });
  }
}
