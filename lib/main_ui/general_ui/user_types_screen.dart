import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/settings/terms_policy.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class UserTypeScreen extends StatefulWidget {
  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen>
    implements IRoundedButtonClicked {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'images/appicon.jpeg',
                      width: ScreenDimensions.getScreenWidth(context) / 1.39,
                      // height: ScreenDimensions.getScreenWidth(context) / 1.39,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Others.getSizedBox(boxHeight: 25, boxWidth: 0),
                  AppButtons.getRoundedButton(
                    context: context,
                    iRoundedButtonClicked: this,
                    label: 'Customer',
                    clickType: ClickType.PATIENT,
                  ),
                  Others.getSizedBox(boxHeight: 24, boxWidth: 0),
                  AppButtons.getRoundedButton(
                    context: context,
                    iRoundedButtonClicked: this,
                    label: 'Service Provider',
                    clickType: ClickType.PRACTITIONER,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          text:
                          'We are committed to providing you quality service and a great experience, please read on our ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Community Guidelines, ',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => NavigationController.push(
                                  context,
                                  WebViewPage(
                                    link: StringConstants.COMMUNITY_GUIDLINES,
                                    title: 'Community Guidelines',
                                  ),
                                ),
                            ),
                            TextSpan(
                              text: 'Data Privacy and Protection ',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => NavigationController.push(
                                  context,
                                  WebViewPage(
                                    link: StringConstants.PRIVACY_POLICY_LINK,
                                    title: 'Data Privacy and Protection',
                                  ),
                                ),
                            ),
                            TextSpan(
                              text: ', and EULA',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => NavigationController.push(
                                  context,
                                  WebViewPage(
                                    link: StringConstants.EULA_LINK,
                                    title: 'EULA',
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  onClick(ClickType userType) {
    NavigationController.pushReplacement(context, LoginScreen(userType));
  }
}