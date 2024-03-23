import 'package:every_school_project_but_in_flutter/bloc/blocs/counter_bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/blocs/random_bloc.dart';
import 'package:every_school_project_but_in_flutter/screens/CameraScreen.dart';
import 'package:every_school_project_but_in_flutter/screens/counterScreen.dart';
import 'package:every_school_project_but_in_flutter/screens/galleryScreen.dart';
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
          BlocProvider(create: ((context) => CounterChangeBloc())),
          BlocProvider(create: ((context) => RandomNumberBloc())),
        ],
        child: MaterialApp(
          title: 'Every Project in Flutter',
          initialRoute: "/",
          routes: {
            "/counter": (context) => const CounterScreen(),
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera)), // goto camera
              Tab(icon: Icon(Icons.photo)), // goto gallery
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CameraScreen(), // show camera
            GalleryScreen(), // show gallery
          ],
        ),
      ),
    );
  }
}
