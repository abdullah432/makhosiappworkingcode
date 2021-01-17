import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/traditional_healers_screenone.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/tradional_healer_register_screen_main.dart';
import 'package:provider/provider.dart';

class RegisterSuccessScreen extends StatefulWidget {
  ClickType _clickType;
  String serviceType;
  RegisterSuccessScreen(this._clickType, {this.serviceType});

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen>
    implements IRoundedButtonClicked {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            Image.asset(
              'images/done.png',
              height: 180,
              width: 180,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'You have successfully Registered',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget._clickType == ClickType.PATIENT
                  ? 'AS A CUSTOMER'
                  : 'AS A SERVICE PROVIDER',
              style: TextStyle(
                fontSize: 21,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Others.getSizedBox(boxHeight: 80, boxWidth: 0),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'GO HOME',
              clickType: widget._clickType,
            ),
          ],
        ),
      ),
    );
  }

  @override
  onClick(ClickType clickType) {
    Object targetScreen;
    switch (clickType) {
      case ClickType.PATIENT:
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
      case ClickType.PRACTITIONER:
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
      case ClickType.LOGIN:
        break;
      case ClickType.DUMMY:
        break;
    }
    if (widget.serviceType != null && widget.serviceType == 'Abelaphi')
      NavigationController.pushReplacement(context, OnBoardingOne());
    else
      NavigationController.pushReplacement(context, targetScreen);
  }
}
