import 'package:bmiapp/screens/gender/gender.dart';
import 'package:bmiapp/screens/weight/weight_page.dart';
import 'package:flutter/material.dart';

import '../../utlis/widget_utils.dart';
import '../input_summary_card.dart';
import 'gender_card.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  Gender gender = Gender.other;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenderCard(
                  initialGender: gender,
                  onChanged: (val) => setState(() => gender = val),
                ),
                Container(
                  margin: EdgeInsets.all(screenAwareSize(15.0, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Selected Gender:"),
                          Card(
                            child: Container(
                                margin: EdgeInsets.all(
                                    screenAwareSize(10.0, context)),
                                child: Center(
                                  child: _genderText(),
                                )),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeightPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                EdgeInsets.all(screenAwareSize(10.0, context)),
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
            )
          ],
        ),
      ),
    );
  }

  Widget _genderText() {
    String genderText = gender == Gender.other
        ? 'Other'
        : (gender == Gender.male ? 'Male' : 'Female');
    return _text(genderText);
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
