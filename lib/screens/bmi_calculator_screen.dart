import 'package:every_school_project_but_in_flutter/bloc/blocs/bmi_calculator_bloc.dart';
import 'package:every_school_project_but_in_flutter/bloc/events/bmi_calculator/bmi_calculator_event.dart';
import 'package:every_school_project_but_in_flutter/bloc/states/bmi_calculator/bmi_calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    debugPrint("BmiCalculatorScreenState initstate");
    super.initState();
  }

  @override
  void dispose() {
    // dispose bloc if you use subscriptions in bloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiCalculatorBloc, BmiCalculatorState>(
      listener: (context, state) {
        debugPrint("listening on bmi... ${state.bmi}");
        if (state.bmi > 0) {
          String group = "something went wrong...";
          if (state.bmi < 18.5) {
            group = "body weight deficit";
          } else if (state.bmi >= 18.5 && state.bmi < 24) {
            group = "norm";
          } else if (state.bmi >= 24 && state.bmi < 30) {
            group = "over weight";
          } else if (state.bmi >= 30 && state.bmi < 35) {
            group = "obesity first degree";
          } else if (state.bmi >= 35 && state.bmi < 40) {
            group = "obesity second degree";
          } else if (state.bmi >= 40) {
            group = "obesity third degree";
          } else {
            debugPrint("BMI is out of expected range.");
          }
          debugPrint("your group is:  $group");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Your BMI is: ${state.bmi.toStringAsFixed(2)}, which falls into the category: $group"),
            backgroundColor: Colors.blue,
          ));
        } else {
          debugPrint("bmi 0");
        }
      },
      builder: (context, state) {
        return Material(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Weight:'),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: "weight / Kilomgrams"),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please input weight.";
                          }
                          return null;
                        },
                        onChanged: (weight) {
                          debugPrint("weight changed. $weight");
                          BlocProvider.of<BmiCalculatorBloc>(context).add(
                              WeightChangedEvent(weight: double.parse(weight)));
                        }),
                    const Text('height:'),
                    TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        decoration: const InputDecoration(
                            hintText: "height / centimenter"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please input height.";
                          }
                          return null;
                        },
                        onChanged: (height) {
                          debugPrint("height changed. $height");
                          BlocProvider.of<BmiCalculatorBloc>(context).add(
                              HeightChangedEvent(height: double.parse(height)));
                        }),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "try again. something went wrong.")));
                          } else {
                            // context.read<BmiCalculatorBloc>().add(BmiFormSubmitEvent());
                            BlocProvider.of<BmiCalculatorBloc>(context)
                                .add(BmiFormSubmitEvent());
                          }
                        },
                        child: const Text("submit"),
                      ),
                    )
                  ],
                )));
      },
    );
  }
}
