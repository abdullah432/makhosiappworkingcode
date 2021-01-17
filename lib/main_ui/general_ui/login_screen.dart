import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/enums/social_login_type.dart';
import 'package:makhosi_app/helpers/auth/login/login_helper.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/password_reset_screen.dart';
import 'package:makhosi_app/main_ui/general_ui/user_types_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/auth/patient_register_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/practitioner_register_screen_first.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_first_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/ui_components/settings/terms_policy.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:makhosi_app/utils/string_constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  ClickType _userType;

  LoginScreen(this._userType);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements IRoundedButtonClicked {
  bool _isLoading = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  LoginHelper _loginHelper = LoginHelper();
  PreferencesHelper _preferencesHelper = PreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.MAROON_RED,
        body: Stack(
          children: [
            _getBody(),
            _getBackButton(),
            _isLoading
                ? AppStatusComponents.loadingContainer(AppColors.COLOR_GREY)
                : Container(),
          ],
        ),
      ),
      onWillPop: () {
        NavigationController.pushReplacement(context, UserTypeScreen());
      },
    );
  }

  Widget _getBackButton() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      alignment: Alignment.topLeft,
      width: ScreenDimensions.getScreenWidth(context),
      height: ScreenDimensions.getScreenHeight(context),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey,
        ),
        onPressed: () {
          NavigationController.pushReplacement(context, UserTypeScreen());
        },
      ),
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.all(32),
      width: ScreenDimensions.getScreenWidth(context),
      height: ScreenDimensions.getScreenHeight(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/logo-full.png'),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            AppTextFields.getLoginField(
              controller: _emailController,
              label: 'Email',
              isPassword: false,
              isNumber: false,
            ),
            Others.getSizedBox(boxHeight: 16, boxWidth: 0),
            AppTextFields.getLoginField(
              controller: _passwordController,
              label: 'Password',
              isPassword: true,
              isNumber: false,
            ),
            Others.getSizedBox(boxHeight: 16, boxWidth: 0),
            _getForgotPasswordSection(),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'Login',
              clickType: ClickType.LOGIN,
            ),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            widget._userType == ClickType.PATIENT
                ? AppLabels.getLabel(
              labelText: 'Or connect with',
              size: 15,
              labelColor: Colors.grey,
              isBold: false,
              isUnderlined: false,
              alignment: TextAlign.center,
            )
                : Container(),
            Others.getSizedBox(boxHeight: 8, boxWidth: 0),
            _getSocialLoginSection(),
            Others.getSizedBox(boxHeight: 16, boxWidth: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLabels.getLabel(
                  labelText: 'Sign Up or Register',
                  size: 15,
                  labelColor: Colors.white,
                  isBold: false,
                  isUnderlined: false,
                  alignment: TextAlign.center,
                ),
                Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                GestureDetector(
                  onTap: () {
                    Object targetScreen;
                    switch (widget._userType) {
                      case ClickType.PATIENT:
                        targetScreen =
                            PatientRegisterScreen(widget._userType, null);
                        break;
                      case ClickType.PRACTITIONER:
                        targetScreen =
                            ServiceProviderRegisterScreenOne(widget._userType);
                        break;
                    }
                    NavigationController.pushReplacement(context, targetScreen);
                  },
                  child: AppLabels.getLabel(
                    labelText: 'HERE',
                    size: 15,
                    labelColor: AppColors.COLOR_PRIMARY,
                    isBold: false,
                    isUnderlined: true,
                    alignment: TextAlign.center,
                  ),
                ),
              ],
            ),
            Others.getSizedBox(boxHeight: 32, boxWidth: 0),
            RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                text: '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Ts&Cs, ',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => NavigationController.push(
                        context,
                        WebViewPage(
                          link: StringConstants.EULA_LINK,
                          title: 'Ts&Cs',
                        ),
                      ),
                  ),
                  TextSpan(
                    text: 'Data Privacy and Protection ',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => NavigationController.push(
                        context,
                        WebViewPage(
                          link: StringConstants.PRIVACY_POLICY_LINK,
                          title: 'Data Privacy and Protection',
                        ),
                      ),
                  ),
                ],
              ),
            ),

            // AppLabels.getLabel(
            //   labelText: 'Ts&Cs, Privacy Policy',
            //   size: 15,
            //   labelColor: Colors.white,
            //   isBold: false,
            //   isUnderlined: false,
            //   alignment: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _getSocialLoginSection() {
    return widget._userType == ClickType.PATIENT
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // _getSocialLoginButton(
        //   SocialLoginType.FACEBOOK,
        //   'images/facebook.png',
        // ),
        _getSocialLoginButton(
          SocialLoginType.GOOGLE,
          'images/google.png',
        ),
        // _getSocialLoginButton(
        //   SocialLoginType.TWITTER,
        //   'images/twitter.png',
        // ),
      ],
    )
        : Container();
  }

  Widget _getSocialLoginButton(SocialLoginType socialLoginType, String image) {
    return GestureDetector(
      onTap: () {
        switch (socialLoginType) {
          case SocialLoginType.GOOGLE:
            _handleGoogleLogin();
            break;
          case SocialLoginType.FACEBOOK:
          // TODO: Handle this case.
            break;
          case SocialLoginType.TWITTER:
          // TODO: Handle this case.
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 40,
        height: 40,
        color: AppColors.LIGHT_GREYISH_RED,
        child: Image.asset(image),
      ),
    );
  }

  Future<void> _handleGoogleLogin() async {
    setState(() {
      _isLoading = true;
    });
    bool result = await LoginHelper().loginUsingGoogle();
    if (result) {
      NavigationController.pushReplacement(context, PatientHome());
    } else {
      AppToast.showToast(message: 'Error logging in');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _getForgotPasswordSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            NavigationController.push(context, PasswordResetScreen());
          },
          child: AppLabels.getLabel(
            labelText: 'Forgot Password?',
            size: 15,
            labelColor: AppColors.COLOR_PRIMARY,
            isBold: true,
            isUnderlined: true,
            alignment: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  onClick(ClickType clickType) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (_loginHelper.validateLoginCredentials(
        email: email, password: password)) {
      setState(() {
        _isLoading = true;
      });
      bool authStatus = await _loginHelper.loginUser(
        email: email,
        password: password,
        userType: widget._userType,
      );
      if (authStatus) {
        await _preferencesHelper.setUserType(widget._userType);
        Object targetScreen;
        switch (widget._userType) {
        // ignore: missing_enum_constant_in_switch
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
        }
        NavigationController.pushReplacement(context, targetScreen);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}