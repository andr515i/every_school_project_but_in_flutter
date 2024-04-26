import 'package:every_school_project_but_in_flutter/counter/bloc/counter_bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_bloc.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_number_event.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/counter_change_state.dart';
import 'package:every_school_project_but_in_flutter/counter/bloc/random_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/counter_change_event.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterChangeBloc counterBloc = Provider.of(context, listen: false);
    final RandomNumberBloc randomBloc = Provider.of(context, listen: false);
    return Scaffold(
        body: BlocBuilder<CounterChangeBloc, CounterChangeState>(
            builder: ((context, state) => Center(
                  child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
                    builder: ((rndContext, rndState) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'You have pushed the button this many times:',
                              ),
                              BlocListener<CounterChangeBloc,
                                  CounterChangeState>(
                                listener: (context, state) {
                                  if (state.currentValue % 3 == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.purple,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(
                                            'Modulus hit:  ${state.currentValue}'),
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<CounterChangeBloc,
                                    CounterChangeState>(
                                  builder: (context, state) {
                                    return Text('${state.currentValue}');
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      "Random Number Counter: ${rndState.currentValue}")
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      counterBloc.add(CounterIncrementEvent());
                                    },
                                    tooltip: 'Increment',
                                    child: const Icon(Icons.add),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      counterBloc.add(CounterDecrementEvent());
                                    },
                                    tooltip: 'Decrement',
                                    child: const Icon(Icons.remove),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      randomBloc.add(RandomIncrementEvent());
                                    },
                                    tooltip: 'Random Increment',
                                    child: const Icon(Icons.add_box),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      randomBloc.add(RandomDecrementEvent());
                                    },
                                    tooltip: 'Random Decrement',
                                    child: const Icon(Icons.remove_circle),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ))));
  }
}
