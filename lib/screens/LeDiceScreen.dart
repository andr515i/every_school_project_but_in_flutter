
import 'package:every_school_project_but_in_flutter/bloc/blocs/LeDice_bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/events/LeDice/DiceThrowEvent.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/LeDice/LeDice_State.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeDiceScreen extends StatefulWidget {
  const LeDiceScreen({
    super.key,
  });
  @override
  State<LeDiceScreen> createState() {
    return LeDiceScreenState();
  }
}

class LeDiceScreenState extends State<LeDiceScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // dispose bloc if you use subscriptions in bloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeDiceBloc, LeDiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The dice landed on: ${state.currentDiceNumber}'),
            FloatingActionButton(
                onPressed: () => BlocProvider.of<LeDiceBloc>(context)
                    .add(LeDiceThrowEvent()),
                child: Icon(
                  Icons.widgets,
                  color: state.color,
                )),
          ],
        ));
      },
    );
  }
}
