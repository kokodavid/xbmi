import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utlis/widget_utils.dart';
import 'dart:math' as math;

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int? weight;
  int? height;
  String? gender;
  double? result;

  @override
  void initState() {
    getPrefData();
    super.initState();
  }

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      weight = pref.getInt("weight");
      height = pref.getInt("height");
      gender = pref.getString("gender");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(vertical: kToolbarHeight),
      child: Column(
        children: [
          Text("Selected Values:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                height: 150,
                width: 100,
                color: Colors.red,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Weight:"),
                    _text(weight.toString()),
                    Text("Kg"),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.all(8),
                height: 150,
                width: 100,
                color: Colors.red,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Height:"),
                    _text(height.toString()),
                    Text("Cm"),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: 100,
                height: 150,
                color: Colors.red,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Gender:"),
                    _text(gender.toString()),
                  ],
                )),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                result = calculateBMI(weight!, height!);
              });
              log(result.toString());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(screenAwareSize(10.0, context)),
                child: const Text(
                  "Calculate BMI",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ),
          Container(
            child: _textResult("${result.toString()} KG/m2"),
          )
        ],
      ),
    ));
  }

  calculateBMI(int weight, int height) {
    double calculate = weight / math.pow(height / 100, 2);
    double result = double.parse(calculate.toStringAsFixed(2));
    return result;
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 26.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _textResult(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 60.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
