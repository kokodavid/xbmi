import 'package:bmiapp/screens/gender/gender.dart';
import 'package:bmiapp/screens/gender/gender_card.dart';
import 'package:bmiapp/screens/height/height_card.dart';
import 'package:bmiapp/screens/weight/weight_card.dart';
import 'package:flutter/material.dart';

import '../utlis/app_bar.dart';
import '../utlis/widget_utils.dart';
import 'input_page_styles.dart';
import 'input_summary_card.dart';

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender gender = Gender.other;
  int height = 170;
  int weight = 70;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight(context)),
          child: BmiAppBar()),
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputSummaryCard(
              gender: gender,
              weight: weight,
              height: height,
            ),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(108.0, context),
      width: double.infinity,
      child: Switch(value: true, onChanged: (val) {}),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: screenAwareSize(32.0, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: GenderCard(
                  initialGender: gender,
                  onChanged: (val) => setState(() => gender = val),
                )),
                Expanded(
                  child: WeightCard(
                    weight: weight,
                    onChanged: (val) => setState(() => weight = val),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: HeightCard(
              height: height,
              onChanged: (val) => setState(() => height = val),
            ),
          ),
        ],
      ),
    );
  }
}
