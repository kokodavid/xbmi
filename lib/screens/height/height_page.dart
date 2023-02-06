import 'package:bmiapp/screens/height/height_card.dart';
import 'package:flutter/material.dart';

import '../../utlis/widget_utils.dart';

class HeightPage extends StatefulWidget {
  HeightPage({super.key});

  int? initialHeight;

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int? height;

  @override
  void initState() {
    height = widget.initialHeight ?? 170;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 390,
                child: HeightCard(
                  onChanged: (val) => setState(
                    () => height = val,
                  ),
                  height: height!,
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
                              child: Text("${height} cm"),
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
                          "Calculate BMI",
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
      ),
    );
  }
}
