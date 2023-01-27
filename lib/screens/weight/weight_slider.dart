// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class WeightSlider extends StatelessWidget {
  const WeightSlider({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.width,
  }) : super(key: key);

  final int minValue;
  final int maxValue;
  final double width;

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {
    int itemCount = (maxValue - minValue) + 3;
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemExtent: itemExtent,
      itemCount: itemCount,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final int value = _indexToValue(index);
        bool isExtra = index == 0 || index == itemCount - 1;

        return isExtra
            ? new Container() //empty first and last element
            : Center(
                child: new Text(
                  value.toString(),
                  style: _getTextStyle(),
                ),
              );
      },
    );
  }

  TextStyle _getTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 13.0,
    );
  }
}