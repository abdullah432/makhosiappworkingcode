import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:screenshot/screenshot.dart';
//import 'package:flutter_linkedin/linkedloginflutter.dart';
//import 'dart:async';

//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class BusinessCard extends StatefulWidget {
  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Map<String, dynamic> _data;
  File image1;
  ByteData byteData;

  getData()async{

    String id = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('service_provider').doc(id).get().then((value) {

      setState(() {
        _data = value.data();
      });
      print(_data);
    });
  }

  bool checkB=false;

  takeShot()async{
    print('sa');
    setState(() {
      checkB=true;
    });
    image1 = await screenshotController.capture(
        pixelRatio: 4
    );
    final bytes = await image1.readAsBytes(); // Uint8List
     byteData = bytes.buffer.asByteData(); //

    setState(() {
      print('sad');
    });
    _shareImage(byteData);
  }
  Future<void> _shareImage(ByteData bytes) async {

    try {
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.').then((value) {
            setState(() {
              checkB=false;
            });
      });
    } catch (e) {
      print('error: $e');
      setState(() {
        checkB=false;
      });
    }
  }
  
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
                      (_data!=null)?
                      Column(
                          children: [
                            sizeBox(14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Padding(
                                //   padding: EdgeInsets.symmetric(horizontal: 5),
                                //   child: Container(
                                //     height: 40,
                                //     width: width * .3,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: AppColors.REQUEST_UPPER_O,
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         'Edit Information',
                                //         style: TextStyle(
                                //           color: AppColors.BUSINESS_TEXT1,
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 9,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                        child:
                                        (_data['id_picture']!=null)? ClipOval(child: Image.network(_data['id_picture'])):Image.asset(
                                            'images/administration_images/avatar.png'),
                                      ),
                                    ),
                                    // Positioned(
                                    //     bottom: 10,
                                    //     right: 5,
                                    //     child: Image.asset(
                                    //       'images/administration_images/check.png',
                                    //       height: 22,
                                    //     ))
                                  ],
                                ),

                                // SizedBox(
                                //   width: 10,
                                // ),
                                // Image.asset('images/Object.png')
                              ],
                            ),
                            sizeBox(10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Screenshot(
                                  controller: screenshotController,
                                  child: Container(
                                    color: Colors.white,
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Center(
                                          child: Text(
                                            '${_data['prefered_buisness_name']} ' ?? 'Business name',
                                            style: TextStyle(
                                              color: AppColors.BUSINESS_TEXT2,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            _data['address'] ?? 'Address',
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
                                            Image.asset(
                                                'images/administration_images/insta.png'),
                                            sizeBoxW(30),
                                            InkWell(
                                              onTap: () {
                                                // login();
                                              },
                                              child: Image.asset(
                                                  'images/administration_images/linkedIn.png'),
                                            ),
                                            sizeBoxW(30),
                                            Image.asset(
                                                'images/administration_images/whatsApp.png'),
                                            sizeBoxW(30),
                                            InkWell(
                                              onTap: () {
                                                //_login();
                                              },
                                              child: Image.asset(
                                                  'images/administration_images/facebook.png'),
                                            )
                                          ],
                                        ),
                                        sizeBox(10),
                                        (_data['company_website_link']!=null)?Center(child: Text(
                                          _data['company_website_link'] ?? 'UrlLink',
                                          style: TextStyle(
                                            color: AppColors.BUSINESS_TEXT2,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                          ),
                                        ),):Container(),
                                        (_data['company_website_link']!=null)?sizeBox(10):Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Years of Service',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                sizeBox(10),
                                                Text(
                                                  _data['practice_years'] ?? '0',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT2,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Languages',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                sizeBox(10),
                                                Text(
                                                  _data['languages'] ?? 'Language',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT2,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Service',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT4,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                sizeBox(10),
                                                Text(
                                                  _data['service_type'] ?? 'Service Type',
                                                  style: TextStyle(
                                                    color: AppColors.BUSINESS_TEXT2,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: [
                                        //     Text(
                                        //       _data['practice_years'] ?? '0',
                                        //       style: TextStyle(
                                        //         color: AppColors.BUSINESS_TEXT2,
                                        //         fontWeight: FontWeight.w500,
                                        //         fontSize: 11,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       _data['languages'] ?? 'Language',
                                        //       style: TextStyle(
                                        //         color: AppColors.BUSINESS_TEXT2,
                                        //         fontWeight: FontWeight.w500,
                                        //         fontSize: 11,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       _data['service_type'] ?? 'Service Type',
                                        //       style: TextStyle(
                                        //         color: AppColors.BUSINESS_TEXT2,
                                        //         fontWeight: FontWeight.w500,
                                        //         fontSize: 11,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
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
                                              _data['service_brief_description'] ?? 'About',
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
                                              _data['business_rules'] ?? 'Business Rules',
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
                                              'Business Operating Times',
                                              style: TextStyle(
                                                color: AppColors.BUSINESS_TEXT2,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),

                                        hourRow('●   Monday to Thursday', '${_data['timings']['monday_open']} : ${_data['timings']['monday_close']}'),
                                        sizeBox(10),
                                        hourRow('●   Friday', '${_data['timings']['friday_open']} : ${_data['timings']['friday_close']}'),
                                        sizeBox(10),
                                        hourRow('●   Saturday and Sunday', '${_data['timings']['sunday_open']} : ${_data['timings']['sunday_close']}'),
                                        // hourRow('●   Monday', '${_data['timings']['monday_open']} : ${_data['timings']['monday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Tuesday', '${_data['timings']['tuesday_open']} : ${_data['timings']['tuesday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Wednesday', '${_data['timings']['wednesday_open']} : ${_data['timings']['wednesday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Thursday', '${_data['timings']['thursday_open']} : ${_data['timings']['thursday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Friday', '${_data['timings']['friday_open']} : ${_data['timings']['friday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Saturday', '${_data['timings']['saturday_open']} : ${_data['timings']['saturday_close']}'),
                                        // sizeBox(5),
                                        // hourRow('●   Sunday', '${_data['timings']['sunday_open']} : ${_data['timings']['sunday_close']}'),

                                        (!checkB)?sizeBox(40):Container(),
                                        (!checkB)?Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .2),
                                          child: GestureDetector(
                                            onTap: (){
                                              takeShot();
                                            },
                                            child: Container(
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(100),
                                                  color: AppColors.COLOR_PRIMARY),
                                              child: Center(
                                                child: Text(
                                                  'Send Business Card',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ):Container(),
                                        (!checkB)?sizeBox(20):Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      :CircularProgressIndicator(),
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
              fontSize: 12,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: AppColors.BUSINESS_TEXT3,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
