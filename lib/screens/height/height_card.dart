import 'package:flutter/material.dart';

import '../../utlis/widget_utils.dart';
import '../card_title.dart';
import 'height_picker.dart';

class HeightCard extends StatelessWidget {
  final int height;
  final ValueChanged<int>? onChanged;

  const HeightCard({Key? key,required this.height, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        right: screenAwareSize(16.0, context),
        left: screenAwareSize(4.0, context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CardTitle(title:"HEIGHT", subtitle: "(cm)"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
              child: LayoutBuilder(builder: (context, constraints) {
                return HeightPicker(
                  widgetHeight: constraints.maxHeight,
                  height: height,
                  onChange: (val) => onChanged!(val),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

