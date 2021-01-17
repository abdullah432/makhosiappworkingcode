import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/traditional_healers_screenone.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:hexcolor/hexcolor.dart';

class OnBoardingOne extends StatefulWidget {
  @override
  _OnBoardingOneState createState() => _OnBoardingOneState();
}

class _OnBoardingOneState extends State<OnBoardingOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              "images/boarding.png",
              height: 200,
              width: 250,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Traditional Healer\n       Onboarding ",
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              "Please take time to go through\n our onboarding process for the\n setting up of your Practice on the\n Mkhosi listing pages. Thank you\n for your coorporation",
              style: TextStyle(color: Colors.black45, fontSize: 13),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          InkWell(
            onTap: () {
              NavigationController.pushReplacement(
                  context, TraditionalHealersScreenFirst());
            },
            child: new Container(
              width: 200.0,
              height: 55.0,
              decoration: new BoxDecoration(
                color: Hexcolor("#252C4A"),
                border: new Border.all(color: Colors.white, width: 2.0),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Center(
                child: new Text('Begin Onboarding',
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
