import 'package:every_school_project_but_in_flutter/LeDiceThrower/bloc/LeDice_bloc.dart';
import 'package:every_school_project_but_in_flutter/Bmi_calculator/bloc/bmi_calculator_bloc.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/bloc/cups_and_ball_bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/counter_bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_bloc.dart';
import 'package:every_school_project_but_in_flutter/LeDiceThrower/screens/LeDiceScreen.dart';
import 'package:every_school_project_but_in_flutter/balls_and_cup/screens/balls_and_cup_screen.dart';
import 'package:every_school_project_but_in_flutter/Bmi_calculator/screens/bmi_calculator_screen.dart';
import 'package:every_school_project_but_in_flutter/counter/screens/counterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => BmiCalculatorBloc())),
          BlocProvider(create: ((context) => CounterChangeBloc())),
          BlocProvider(create: ((context) => RandomNumberBloc())),
          BlocProvider(create: ((context) => LeDiceBloc())),
          BlocProvider(create: ((context) => CupsAndBallBloc())),
          
        ],
        child: MaterialApp(
          title: 'Every Project in Flutter',
          initialRoute: "/",
          routes: {
            "/counter": (context) => const CounterScreen(),
            "/BmiCalculator": (context) => const BmiCalculatorScreen(),
            "/LeDice": (context) => const LeDiceScreen(),
            "/BaC": (context) => const BallAndCupScreen(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Main Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood)), // goto bmi screen
              Tab(icon: Icon(Icons.six_ft_apart)), // goto dice thrower
              Tab(icon: Icon(Icons.games)), // goto ball and cups
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BmiCalculatorScreen(),
            LeDiceScreen(),
            BallAndCupScreen(),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Every app"),
    //   ),
    //   drawer: Drawer(
    //       child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(color: Colors.blue),
    //         child: Text("drawer header"),
    //       ),
    //       ListTile(
    //         title: const Text("Bmi Calculator"),
    //         onTap: () {
    //           Navigator.of(context).pushNamed("/BmiCalculator");
    //         },
    //       ),
    //       ListTile(
    //         title: const Text("Le Dice Thrower"),
    //         onTap: () {
    //           Navigator.of(context).pushNamed("/LeDice");
    //         },
    //       ),
    //       ListTile(
    //         title: const Text("Ball and Cups"),
    //         onTap: () {
    //           Navigator.of(context).pushNamed("/BaC");
    //         },
    //       ),
    //     ],
    //   )),
    // );
  }
}
