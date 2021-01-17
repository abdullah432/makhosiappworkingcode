import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/language_country_page.dart';
import 'package:makhosi_app/main_ui/general_ui/user_types_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription _subscription;
  PreferencesHelper _preferencesHelper = PreferencesHelper();

  @override
  void initState() {
    Others.clearImageCache();
    _subscription = _counter().listen((count) async {
      if (count == 4) {
        navigateToNextScreen();
      }
    });
    super.initState();
  }

  Future<void> navigateToNextScreen() async {
    var language = await _preferencesHelper.getLanguage();
    var country = await _preferencesHelper.getCountry();
    if (language.isEmpty || country.isEmpty)
      NavigationController.pushReplacement(context, LanguageCountrySelect());
    else {
      String userType = await _preferencesHelper.getUserType();
      var user = FirebaseAuth.instance.currentUser;
      Object targetScreen;
      if (user != null) {
        switch (userType) {
          case AppKeys.PATIENT:
            {
              targetScreen = Provider<NotificationProvider>(
                create: (context) {
                  NotificationProvider notificationProvider =
                  NotificationProvider();
                  notificationProvider.firebaseMessaging.subscribeToTopic(
                      'messages_${FirebaseAuth.instance.currentUser.uid}');
                  return notificationProvider;
                },
                child: PatientHome());
              break;
            }
          case AppKeys.PRACTITIONER:
            {
              targetScreen = Provider<NotificationProvider>(
                create: (context) {
                  NotificationProvider notificationProvider =
                  NotificationProvider();
                  notificationProvider.firebaseMessaging.subscribeToTopic(
                      'messages_${FirebaseAuth.instance.currentUser.uid}');
                  return notificationProvider;
                },
                child: PractitionersHome());
              break;
            }
          case 'null':
            {
              targetScreen = UserTypeScreen();
              break;
            }
        }
      } else {
        targetScreen = UserTypeScreen();
      }
      NavigationController.pushReplacement(context, targetScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: ScreenDimensions.getScreenWidth(context),
            height: ScreenDimensions.getScreenHeight(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              right: 10,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF979797),
                    size: 32,
                  ),
                  onPressed: () {
                    navigateToNextScreen();
                  }))
        ],
      ),
    );
  }

  Stream<int> _counter() async* {
    int count = 0;
    while (true) {
      yield count;
      await Future.delayed(
        Duration(seconds: 1),
      );
      count++;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
