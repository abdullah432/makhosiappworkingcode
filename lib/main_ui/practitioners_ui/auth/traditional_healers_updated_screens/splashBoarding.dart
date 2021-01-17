import 'package:flutter/material.dart';
import 'dart:async';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
//ddsdsd
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => PractitionersHome())));


    var assetsImage = new AssetImage(
        'images/screen.jpg'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height:300); //<- Creates a widget that displays an image.

    return  Scaffold(
        body:  image,
      );
  }
}
