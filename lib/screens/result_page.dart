import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int? weight;
  int? height;
  String? gender;

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
        height: 100,
        child: Row(
          children: [
            Text(weight.toString()),
            Text(gender!),
            Text(height.toString())
          ],
        ),
      ),
    );
  }

 
}
