import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/user_types_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/string_constants.dart';
import 'package:provider/provider.dart';

class LanguageCountrySelect extends StatefulWidget {
  @override
  _LanguageCountrySelectState createState() => _LanguageCountrySelectState();
}

class _LanguageCountrySelectState extends State<LanguageCountrySelect> {
  var selectedLanguage = '';
  var selectedCountry = '';
  final _preferencesHelper = PreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomButtion(
                    buttonText: selectedCountry.isEmpty
                        ? 'SELECT COUNTRY'
                        : selectedCountry,
                    onTap: () async {
                      var country =
                          await Navigator.push(context, SelectCountry.route());
                      setState(() {
                        selectedCountry = country.toString();
                      });
                    },
                  ),
                  CustomButtion(
                    buttonText: selectedLanguage.isEmpty
                        ? 'SELECT LANGUAGE'
                        : selectedLanguage,
                    onTap: () async {
                      var lang =
                          await Navigator.push(context, SelectLanguage.route());
                      setState(() {
                        selectedLanguage = lang.toString();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 15,
              child: IconButton(
                  icon: Icon(Icons.arrow_forward_sharp),
                  onPressed: () async {
                    if (selectedCountry.isNotEmpty &&
                        selectedCountry.isNotEmpty) {
                      String userType = await _preferencesHelper.getUserType();
                      var user = FirebaseAuth.instance.currentUser;
                      Object targetScreen;
                      if (user != null) {
                        switch (userType) {
                          case AppKeys.PATIENT:
                            targetScreen = Provider<NotificationProvider>(
                                create: (context) {
                                  NotificationProvider notificationProvider =
                                      NotificationProvider();
                                  notificationProvider.firebaseMessaging
                                      .subscribeToTopic(
                                          'messages_${FirebaseAuth.instance.currentUser.uid}');
                                  return notificationProvider;
                                },
                                child: PatientHome());
                            break;
                          case AppKeys.PRACTITIONER:
                            targetScreen = Provider<NotificationProvider>(
                                create: (context) {
                                  NotificationProvider notificationProvider =
                                      NotificationProvider();
                                  notificationProvider.firebaseMessaging
                                      .subscribeToTopic(
                                          'messages_${FirebaseAuth.instance.currentUser.uid}');
                                  return notificationProvider;
                                },
                                child: PractitionersHome());
                            break;
                          case 'null':
                            {
                              targetScreen = UserTypeScreen();
                              break;
                            }
                        }
                      } else {
                        targetScreen = UserTypeScreen();
                      }
                      NavigationController.pushReplacement(
                          context, targetScreen);
                    }
                  }))
        ],
      ),
    );
  }
}

class SelectLanguage extends StatelessWidget {
  final list = StringConstants.LISTOFLANGUAGES;

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => SelectLanguage());

  final _preferencesHelper = PreferencesHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: ListView(
            shrinkWrap: true,
            children: list
                .map<CustomButtion>((lang) => CustomButtion(
                      buttonText: lang,
                      onTap: lang == 'English'
                          ? () async {
                              await _preferencesHelper.setLanguage(lang);
                              Navigator.pop(context, lang);
                            }
                          : null,
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}

class SelectCountry extends StatelessWidget {
  final list = [
    "South Africa",
    "Tanzania",
    "Lesotho",
    "Swaziland",
    "Kenya",
    "Uganda"
  ];

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => SelectCountry());
  final _preferencesHelper = PreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: ListView(
            shrinkWrap: true,
            children: list
                .map<CustomButtion>((country) => CustomButtion(
                      buttonText: country,
                      onTap: () async {
                        await _preferencesHelper.setCountry(country);

                        Navigator.pop(context, country);
                      },
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }
}

class CustomButtion extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  CustomButtion({this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 50),
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
            color: onTap != null ? AppColors.COLOR_PRIMARY : Colors.grey,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: AppColors.COLOR_WHITE,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}
