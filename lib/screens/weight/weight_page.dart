import 'package:bmiapp/screens/height/height_page.dart';
import 'package:bmiapp/screens/weight/weight_card.dart';
import 'package:flutter/material.dart';

import '../../utlis/widget_utils.dart';

class WeightPage extends StatefulWidget {
  WeightPage({super.key});

  int? initialWeight;

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int? weight;

  @override
  void initState() {
    weight = widget.initialWeight ?? 70;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 250,
              child: WeightCard(
                onChanged: (val) => setState(
                  () => weight = val,
                ),
                weight: weight!,
              )),
          Container(
            margin: EdgeInsets.all(screenAwareSize(15.0, context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("Selected Weight:"),
                    Card(
                      child: Container(
                          margin:
                              EdgeInsets.all(screenAwareSize(10.0, context)),
                          child: Center(
                            child: Text("${weight} kg"),
                          )),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HeightPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(screenAwareSize(10.0, context)),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
