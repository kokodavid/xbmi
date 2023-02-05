import 'package:bmiapp/screens/height/height_card.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
