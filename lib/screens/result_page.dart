import 'dart:developer';

import 'package:bmiapp/screens/gender/gender_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../ad_helper.dart';
import '../utlis/widget_utils.dart';
import 'dart:math' as math;

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  static final AdRequest request = AdRequest();
  int maxFailedLoadAttempts = 3;
  int life = 0;
  late BannerAd _bannerAd;
  late BannerAd _bottomAd;
  bool _isBannerAdReady = false;
  int? weight;
  int? height;
  String? gender;
  double? result;

  @override
  void initState() {
    getPrefData();
    _loadBannerAd();
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
      margin: const EdgeInsets.symmetric(vertical: kToolbarHeight),
      child: Column(
        children: [
          const Text("Selected Values:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: 150,
                width: 100,
                color: Colors.green,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Weight:"),
                    _text(weight.toString()),
                    const Text("Kg"),
                  ],
                )),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                height: 150,
                width: 100,
                color: Colors.green,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Height:"),
                    _text(height.toString()),
                    const Text("Cm"),
                  ],
                )),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 100,
                height: 150,
                color: Colors.green,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Gender:"),
                    _text(gender.toString()),
                  ],
                )),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                result = calculateBMI(weight!, height!);
              });
              log(result.toString());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(screenAwareSize(15.0, context)),
                child: const Text(
                  "Calculate BMI",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ),
          result == null
              ? Container()
              : Column(
                  children: [
                    Container(
                      height: 300,
                      child: Center(
                          child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                              showLabels: false,
                              showAxisLine: false,
                              showTicks: true,
                              minimum: 12,
                              maximum: 48,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 12,
                                    endValue: 18.5,
                                    color: Colors.blue,
                                    label: 'Under\nweight\n<18.5',
                                    sizeUnit: GaugeSizeUnit.factor,
                                    labelStyle: const GaugeTextStyle(
                                        fontFamily: 'Times', fontSize: 16),
                                    startWidth: 0.65,
                                    endWidth: 0.65),
                                GaugeRange(
                                  startValue: 18.5,
                                  endValue: 24.9,
                                  color: Colors.green,
                                  label: 'Normal\n18.5-24.9',
                                  labelStyle: const GaugeTextStyle(
                                      fontFamily: 'Times', fontSize: 16),
                                  startWidth: 0.65,
                                  endWidth: 0.65,
                                  sizeUnit: GaugeSizeUnit.factor,
                                ),
                                GaugeRange(
                                  startValue: 24.9,
                                  endValue: 30,
                                  color: Colors.yellow,
                                  label: 'Over\nweight\n25-29.9',
                                  labelStyle: const GaugeTextStyle(
                                      fontFamily: 'Times', fontSize: 16),
                                  sizeUnit: GaugeSizeUnit.factor,
                                  startWidth: 0.65,
                                  endWidth: 0.65,
                                ),
                                GaugeRange(
                                  startValue: 30,
                                  endValue: 39.9,
                                  color: Colors.orange,
                                  label: 'Obese\n30-39.9',
                                  labelStyle: const GaugeTextStyle(
                                      fontFamily: 'Times', fontSize: 16),
                                  sizeUnit: GaugeSizeUnit.factor,
                                  startWidth: 0.65,
                                  endWidth: 0.65,
                                ),
                                GaugeRange(
                                  startValue: 39.9,
                                  endValue: 48,
                                  color: Colors.red,
                                  label: 'Morbidly\nObese\n>40',
                                  labelStyle: const GaugeTextStyle(
                                      fontFamily: 'Times', fontSize: 16),
                                  sizeUnit: GaugeSizeUnit.factor,
                                  startWidth: 0.65,
                                  endWidth: 0.65,
                                ),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                    value: result == null ? 20 : result!)
                              ])
                        ],
                      )),
                    ),
                    SizedBox(
                        height: 50,
                        child: Column(
                          children: [
                            const Text("Your Body Mass Index:"),
                            result == null
                                ? Container()
                                : _textResult("${result.toString()} KG/m2"),
                          ],
                        )),
                  ],
                ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    clearData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenderPage()),
                    );
                  },
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.replay_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Calculate again",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        Text(
                          "Save Results",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _bottomAd.size.width.toDouble(),
                height: _bottomAd.size.height.toDouble(),
                child: AdWidget(ad: _bottomAd),
              ),
            ),
        ],
      ),
    ));
  }

  calculateBMI(int weight, int height) {
    double calculate = weight / math.pow(height / 100, 2);
    double result = double.parse(calculate.toStringAsFixed(2));
    return result;
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-2470974563764561/1227018819",
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print("ERROR =>>>> ${err.message}");
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bottomAd = BannerAd(
      adUnitId: "ca-app-pub-2470974563764561/1227018819",
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print("ERROR =>>>> ${err.message}");
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    _bottomAd.load();
  }

  Widget _text(String? text) {
    return Text(
      text!,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 26.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _textResult(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 30.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
