import 'package:bmiapp/screens/weight/weight_card.dart';
import 'package:flutter/material.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int weight = 70;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [SizedBox(height: 250,
         child: WeightCard(onChanged: (val) => setState(() => weight = val),)
         )],
      ),
    );
  }
}
