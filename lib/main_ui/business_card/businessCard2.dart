import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/Screens/instagram.dart';
import 'package:makhosi_app/Screens/facebook.dart';
import 'package:makhosi_app/Screens/linkedin.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'dart:async';
import 'package:makhosi_app/main_ui/patients_ui/other/patients_booking_screen.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_linkedin/linkedloginflutter.dart';
//import 'dart:async';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class BusinessCard2 extends StatefulWidget {
  String id,
      firstname,
      location,
      years,
      language,
      service,
      instagram,
      linkedin,
      fb,
      whatsapp;
  BusinessCard2(
      this.id,
      this.firstname,
      this.location,
      this.years,
      this.language,
      this.service,
      this.instagram,
      this.linkedin,
      this.fb,
      this.whatsapp);
  @override
  _BusinessCardState createState() => _BusinessCardState(
      this.firstname,
      this.location,
      this.years,
      this.language,
      this.service,
      this.instagram,
      this.linkedin,
      this.fb,
      this.whatsapp);
}

class _BusinessCardState extends State<BusinessCard2> {
  String firstname,
      location,
      years,
      language,
      service,
      instagram,
      linkedin,
      fb,
      whatsapp;
  _BusinessCardState(this.firstname, this.location, this.years, this.language,
      this.service, this.instagram, this.linkedin, this.fb, this.whatsapp);
  /* static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  void initState() {
    super.initState();
    LinkedInLogin.initialize(context,
        clientId: '77n9tzr490pebq',
        clientSecret: 'eiDD6GEWOTeMqKIY',
        redirectUri:'https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=77n9tzr490pebq&scope=*&state=*&redirect_uri=https://api-university.com/'

    );
  }
  void login(){
    LinkedInLogin.loginForAccessToken(
        destroySession: true,
        appBar: AppBar(
          title: Text('Demo Login Page'),
        ))
        .then((accessToken) => print(accessToken))
        .catchError((error) {
      print(error.errorDescription);
    });
  }*/
  String _platformVersion = 'Unknown';
  dynamic _userProfileSnapshot;
  String _uid;

  @override
  void initState() {
    super.initState();
    _getUserProfileData();
    initPlatformState();
  }

  Future<void> _getUserProfileData() async {
    _userProfileSnapshot = await FirebaseFirestore.instance
        .collection('service_provider')
        .doc(widget.id)
        .get();
    setState(() {});
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            sizeBox(30),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                )),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Container(
                            // height: 500,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          sizeBox(14),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: 40,
                                  width: width * .3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.REQUEST_UPPER_O,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Website',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black87,
                                            blurRadius: 0.1)
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(30.0),
                                      child: Image.asset(
                                          'images/administration_images/avatar.png'),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      right: 5,
                                      child: Image.asset(
                                        'images/administration_images/check.png',
                                        height: 22,
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset('images/Object.png')
                            ],
                          ),
                          sizeBox(10),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Center(
                                  child: Text(
                                    '${firstname}',
                                    style: TextStyle(
                                      color: AppColors.BUSINESS_TEXT2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${location}',
                                    style: TextStyle(
                                      color: AppColors.BUSINESS_TEXT3,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                sizeBox(10),
                                Center(
                                  child: Text(
                                    '● Available Now',
                                    style: TextStyle(
                                      color: AppColors.BUSINESS_TEXT1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                sizeBox(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.BUSINESS_STAR1,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.BUSINESS_STAR1,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.BUSINESS_STAR1,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.BUSINESS_STAR1,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: AppColors.BUSINESS_STAR2,
                                    ),
                                  ],
                                ),
                                sizeBox(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (instagram != null) {
                                          NavigationController.push(
                                              context, Instagram(instagram));
                                        }
                                      },
                                      child: Image.asset(
                                          'images/administration_images/insta.png'),
                                    ),
                                    sizeBoxW(30),
                                    InkWell(
                                      onTap: () {
                                        if (linkedin != null) {
                                          NavigationController.push(
                                              context, LinkedIn(linkedin));
                                        }
                                      },
                                      child: Image.asset(
                                          'images/administration_images/linkedIn.png'),
                                    ),
                                    sizeBoxW(30),
                                    InkWell(
                                      onTap: () {
                                        FlutterOpenWhatsapp.sendSingleMessage(
                                            "03104000953", "Hello");
                                      },
                                      child: Image.asset(
                                          'images/administration_images/whatsApp.png'),
                                    ),
                                    sizeBoxW(30),
                                    InkWell(
                                      onTap: () {
                                        if (fb != null) {
                                          NavigationController.push(
                                              context, Facebook(fb));
                                        }
                                      },
                                      child: Image.asset(
                                          'images/administration_images/facebook.png'),
                                    )
                                  ],
                                ),
                                sizeBox(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Years of Service',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT4,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      'Languages',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT4,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      'Service',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT4,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                sizeBox(30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${years} years',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      '${language}',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      '${service}',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                sizeBox(40),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                sizeBox(20),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'Business Description',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'Thembi Ndlovu is an acreditated Herbalist, with over 5 years experience.  Currently based in Gauteng Province, ',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT3,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBox(10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'Business Rules',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'Thembi Ndlovu is an acreditated Herbalist, with over 5 years experience.  Currently based in Gauteng Province, ',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT3,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBox(10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'Hours',
                                      style: TextStyle(
                                        color: AppColors.BUSINESS_TEXT2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                hourRow('●   Monday to Thursday',
                                    '07:00am : 10:00pm'),
                                sizeBox(10),
                                hourRow('●   Friday', '08:30am : 05:00pm'),
                                sizeBox(10),
                                hourRow('●   Saturday and Sunday',
                                    '08:00am : 08:00pm'),
                                sizeBox(40),
                                InkWell(
                                  onTap: () {
                                    if (_userProfileSnapshot != null)
                                      NavigationController.push(
                                          context,
                                          PatientsBookingScreen(
                                              _userProfileSnapshot));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .2),
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColors.COLOR_PRIMARY),
                                      child: Center(
                                        child: Text(
                                          'Book',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBox(20)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget sizeBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget sizeBoxW(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget align() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }

  Widget hourRow(String text1, String text2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              color: AppColors.BUSINESS_TEXT3,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: AppColors.BUSINESS_TEXT3,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
