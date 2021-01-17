import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/splashBoarding.dart';
class TraditionalHealerRegisterSuccessScreen extends StatefulWidget {
  ClickType _clickType;
  TraditionalHealerRegisterSuccessScreen(this._clickType);

  @override
  _TraditionalHealerRegisterSuccessScreenState createState() =>
      _TraditionalHealerRegisterSuccessScreenState();
}

class _TraditionalHealerRegisterSuccessScreenState
    extends State<TraditionalHealerRegisterSuccessScreen>
    implements IRoundedButtonClicked {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/done.png'),
            Text(
              'You have successfully onboarded',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Others.getSizedBox(boxHeight: 32, boxWidth: 0),
            Text(
              'AS A TRADITIONAL HEALER',
              style: TextStyle(
                fontSize: 21,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            Others.getSizedBox(boxHeight: 32, boxWidth: 0),
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

    NavigationController.pushReplacement(
        context, SplashScreen());
   }
}
