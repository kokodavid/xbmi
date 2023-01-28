import 'package:bmiapp/screens/weight/weight_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utlis/widget_utils.dart';
import '../card_title.dart';

class WeightCard extends StatefulWidget {
  final int? initialWeight;

  const WeightCard({super.key, this.initialWeight});

  @override
  _WeightCardState createState() => _WeightCardState();
}



class _WeightCardState extends State<WeightCard> {

  int? weight;
  @override
  void initState() {
    weight = widget.initialWeight ?? 70;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(32.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("WEIGHT", subtitle: "(KG)"),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _drawSlider(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _drawSlider() {
  return WeightBackground(
    child: LayoutBuilder(
      builder: (context, constraints) {
        return constraints.isTight
            ? Container()
            : WeightSlider(
                minValue: 30,
                maxValue: 110,
                value: weight!,
                onChanged: (val) => setState(() => weight = val),
                width: constraints.maxWidth,
              );
      },
    ),
  );
}

}

  class WeightBackground extends StatelessWidget {
  final Widget? child;

  const WeightBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: screenAwareSize(100.0, context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
                new BorderRadius.circular(screenAwareSize(50.0, context)),
          ),
          child: child,
        ),
        SvgPicture.asset(
          "images/weight_arrow.svg",
          height: screenAwareSize(10.0, context),
          width: screenAwareSize(18.0, context),
        ),
      ],
    );
  }
}