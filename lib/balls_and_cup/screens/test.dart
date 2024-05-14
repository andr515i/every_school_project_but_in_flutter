
import 'package:flutter/material.dart';
import 'dart:math';

//https://dartpad.dev/?id=17b4a8c747aeb2583a90ca865e7abff6

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DiceCodeScreen(),
    );
  }
}

class DiceCodeScreen extends StatefulWidget {
  const DiceCodeScreen({super.key});
  @override
  createState() => _DiceCodeState();
}

class _DiceCodeState extends State<DiceCodeScreen>
    with SingleTickerProviderStateMixin {
  // List to hold the positions of the boxes
  List<Offset> positions = [];
  final Random _random = Random();
  late AnimationController _controller;

  // init State Override
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  // Dispose Override
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _randomSwap() {
    int firstBox = _random.nextInt(3);
    int secondBox;
    do {
      secondBox = _random.nextInt(3);
    } while (firstBox == secondBox);

    setState(() {
      Offset temp = positions[firstBox];
      positions[firstBox] = positions[secondBox];
      positions[secondBox] = temp;
      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    // setPositions();
    if (positions.isEmpty) {
      positions = [
        Offset((MediaQuery.of(context).size.width / 2 - (90 * 1.5)) + 100.0 * 0,
            MediaQuery.of(context).size.height / 2 - 90.0),
        Offset((MediaQuery.of(context).size.width / 2 - (90 * 1.5)) + 100.0 * 1,
            MediaQuery.of(context).size.height / 2 - 90.0),
        Offset((MediaQuery.of(context).size.width / 2 - (90 * 1.5)) + 100.0 * 2,
            MediaQuery.of(context).size.height / 2 - 90.0)
      ];
    }
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: List.generate(3, (index) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                left: positions[index].dx,
                top: positions[index].dy,
                child: GestureDetector(
                  onTap: _randomSwap,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.blue[(index + 1) * 200],
                      border: Border.all(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    child: Text("Box ${index + 1}"),
                  ),
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () => _randomSwap(),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: const Color.fromRGBO(37, 37, 37, 0.87)),
              child: const Text(
                'Shuffle',
                textScaler: TextScaler.linear(2),
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
InkWell(
  child: Image.asset(
    images[0],
    height: 120,
  ),
  onTap: () => {},
),
*/

/*
ElevatedButton(
  onPressed: () {
    // Shuffle Button
    context.read<BallCupsBloc>().add(SwapRandom());
  },
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    backgroundColor: const Color.fromRGBO(37, 37, 37, 0.87)),
  child: const Text(
    'Shuffle',
    textScaler: TextScaler.linear(2),
    style: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
  ),
),
*/