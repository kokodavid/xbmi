import 'package:bmiapp/screens/gender/gender.dart';
import 'package:bmiapp/screens/weight/weight_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ad_helper.dart';
import '../../utlis/widget_utils.dart';
import 'gender_card.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  Gender gender = Gender.other;
  static final AdRequest request = AdRequest();
  int maxFailedLoadAttempts = 3;
  int life = 0;
  late BannerAd _bannerAd;
  late BannerAd _bottomAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _loadBannerAd();
    super.initState();
  }

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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: GenderCard(
                    initialGender: gender,
                    onChanged: (val) => setState(() => gender = val),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(screenAwareSize(15.0, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text("Selected Gender:"),
                          Card(
                            child: Container(
                                margin: EdgeInsets.all(
                                    screenAwareSize(10.0, context)),
                                child: Center(
                                  child: Text(_genderText()),
                                )),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          saveStringData("gender", _genderText());
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
                      ),
                      // if (_isBannerAdReady)
                      //   Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Container(
                      //       width: _bannerAd.size.width.toDouble(),
                      //       height: _bannerAd.size.height.toDouble(),
                      //       child: AdWidget(ad: _bannerAd),
                      //     ),
                      //   ),
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
            )
          ],
        ),
      ),
    );
  }

  _genderText() {
    String genderText = gender == Gender.other
        ? 'Other'
        : (gender == Gender.male ? 'Male' : 'Female');
    return genderText;
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

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-2470974563764561/6522695644",
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
      adUnitId: "ca-app-pub-2470974563764561/1812523932",
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
