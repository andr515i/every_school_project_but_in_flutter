import 'package:flutter/material.dart';

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
    debugPrint("BallAndCupState initstate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
