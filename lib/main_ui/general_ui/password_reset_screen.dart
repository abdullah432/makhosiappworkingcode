import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/helpers/auth/reset_password/password_reset_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/user_types_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen>
    implements IRoundedButtonClicked {
  bool _isLoading = false;
  var _emailController = TextEditingController();
  PasswordResetHelper _passwordResetHelper = PasswordResetHelper();

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
          Navigator.pop(context);
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
            Image.asset('images/auth_logo.png'),
            AppLabels.getLabel(
              labelText:
                  'A password reset link will be sent to your mentioned email address',
              size: 19,
              labelColor: Colors.white,
              isBold: true,
              isUnderlined: false,
              alignment: TextAlign.center,
            ),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            AppTextFields.getLoginField(
              controller: _emailController,
              label: 'Email',
              isPassword: false,
              isNumber: false,
            ),
            Others.getSizedBox(boxHeight: 24, boxWidth: 0),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'SEND RESET LINK',
              clickType: ClickType.LOGIN,
            ),
          ],
        ),
      ),
    );
  }

  @override
  onClick(ClickType userTye) async {
    String email = _emailController.text.trim();
    if (_passwordResetHelper.validateLoginCredentials(email: email)) {
      setState(() {
        _isLoading = true;
      });

      await _passwordResetHelper.sendPasswordResetLink(email: email);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
