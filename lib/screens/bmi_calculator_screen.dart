import 'package:every_school_project_but_in_flutter/bloc/blocs/bmi_calculator_bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/events/bmi_calculator/bmi_calculator_event.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/bmi_calculator/bmi_calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({
    super.key,
  });
  @override
  State<BmiCalculatorScreen> createState() {
    return BmiCalculatorScreenState();
  }
}

class BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
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
    return Material(
        child: BlocConsumer<BmiCalculatorBloc, BmiCalculatorState>(
      listener: (context, state) {
        debugPrint("listening on bmi... ${state.bmi}");
        if (state.bmi > 0) {
          String group = "something went wrong...";
          switch (state.bmi) {
            case < 18.5: // 1
              {
                group = "body weight deficit";
              }
              break;
            case > 18.5 && <24:  // 2
              {
                group = "norm";
              }
              break;
            case > 24 && <30: // 3
              {
                group = "over weight";
              }
              break;
            case > 30 && <35: // 4
              {
                group = "obesity first degree";
              }
              break;
            case > 35 && < 40: // 5
              {
                group = "obesity second degree";
              }
              break;
            case > 40: // 6
              {
                group = "obesity third degree";
              }
              break;

          }
          Center(
              child: Column(children: [
            Text(
                "Your BMI is: ${state.bmi}\n this means you are in group:\n $group ")
          ]));
        }
      },
      builder: (context, state) {
        return Material(
            child: Form(
                key: formKey,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "weight"),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      validator: (value) {
                        try {
                          if (value == null || value.isEmpty) {
                            return "please input weight.";
                          }
                        } catch (e) {
                          return "something went wrong...";
                        }
                      },
                      onChanged: (weight) => context
                          .read<BmiCalculatorBloc>()
                          .add(
                              WeightChangedEvent(weight: double.parse(weight))),
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      decoration: const InputDecoration(hintText: "height"),
                      validator: (value) {
                        try {
                          if (value == null || value.isEmpty) {
                            return "please input height.";
                          }
                        } catch (e) {
                          return "something went wrong...";
                        }
                      },
                      onChanged: (height) => context
                          .read<BmiCalculatorBloc>()
                          .add(
                              HeightChangedEvent(height: double.parse(height))),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "try again. something went wrong.")));
                          } else {
                            context
                                .read<BmiCalculatorBloc>()
                                .add(BmiFormSubmitEvent());
                          }
                        },
                        child: const Text("submit"),
                      ),
                    )
                  ],
                ))));
      },
    ));
  }
}
