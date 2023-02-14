import 'package:bmiapp/screens/height/height_card.dart';
import 'package:bmiapp/screens/result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ad_helper.dart';
import '../../utlis/widget_utils.dart';
import '../gender/gender.dart';

class HeightPage extends StatefulWidget {
  HeightPage({super.key});

  int? initialHeight;

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  Gender gender = Gender.other;
  static final AdRequest request = AdRequest();
  int maxFailedLoadAttempts = 3;
  int life = 0;
    late BannerAd _bannerAd;
  late BannerAd _bottomAd;
  bool _isBannerAdReady = false;

  int? height;

  @override
  void initState() {
    height = widget.initialHeight ?? 170;
    _loadBannerAd();
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
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
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
                              child: Text("$height cm"),
                            )),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      saveIntData("height", height!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPage()),
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
      ),
    );
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-2470974563764561/2550890536",
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
      adUnitId: "ca-app-pub-2470974563764561/1237808861",
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
}
