import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/helpers/auth/register/register_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/traditional_healer_register_sucess.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_fourth.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

// ignore: must_be_immutable
class TraditionalHealersScreenThree extends StatefulWidget {
  Map<String, Object> _userData;

  TraditionalHealersScreenThree(this._userData);

  @override
  _TraditionalHealersScreenThreeState createState() =>
      _TraditionalHealersScreenThreeState();
}

class _TraditionalHealersScreenThreeState
    extends State<TraditionalHealersScreenThree>
    implements IRoundedButtonClicked {
  var _patiendReferDetailController = TextEditingController();
  var _associationLinkController = TextEditingController();
  //checkbox
  bool informationProvidedIsCorrect = true;
  //isloading
  bool _isLoading = false;
  //formkey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            _getForm(),
            _isLoading
                ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _getForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Others.getSizedBox(boxHeight: 5, boxWidth: 0),
          Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text(
            'The information in this section is required to conduct verification of the residence of Abelaphi. ',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.COLOR_GREY,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getMultiLineRegisterField(
            controller: _patiendReferDetailController,
            label:
                'Name of patients you want to refer to the app? Please provide name and email',
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _associationLinkController,
            label:
                'Do you belong to an association? If yes please provide details',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          _getPermissionSwitch(),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppButtons.getRoundedButton2(
            context: context,
            iRoundedButtonClicked: this,
            label: 'NEXT',
            clickType: ClickType.DUMMY,
          ),
        ],
      ),
    );
  }

  Widget _getPermissionSwitch() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
            value: informationProvidedIsCorrect,
            onChanged: (val) {
              setState(() {
                informationProvidedIsCorrect = val;
              });
            }),
        Flexible(
          fit: FlexFit.tight,
          child: Text('I declare that information Provided is correct'),
        ),
      ],
    );
  }

  Widget _getBackButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // NavigationController.pushReplacement(
              //     context, PractitionerRegisterScreenSecond(widget._userData));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          AppLabels.getLabel(
            labelText: '',
            size: 21,
            labelColor: Colors.black,
            isBold: false,
            isUnderlined: false,
            alignment: TextAlign.left,
          ),
        ],
      ),
    );
  }

// var _patiendReferDetailController = TextEditingController();
//   var _associationLinkController = TextEditingController();
//   //checkbox
//   bool informationProvidedIsCorrect = true;
  @override
  onClick(ClickType clickType) async {
    String patientRefer = _patiendReferDetailController.text.trim();
    String association = _associationLinkController.text.trim();
    if (!informationProvidedIsCorrect) {
      AppToast.showToast(
          message: 'Please confirm the information you provided is correct');
    } else {
      widget._userData.addAll({
        AppKeys.PATIENTS_REFER_TO_APP: patientRefer,
        AppKeys.ASSOCIATION_NUMBER: association,
      });
      //update data to user account
      // RegisterHelper helper = RegisterHelper();
      setState(() {
        _isLoading = true;
      });
      // final result = await helper.updateTraditionalHealerDataToFirestore(
      //   userInfoMap: widget._userData);
      setState(() {
        _isLoading = false;
      });
      // if (result) {
      AppToast.showToast(message: 'Registration Sucess');
      NavigationController.push(
        context,
        TraditionalHealerRegisterSuccessScreen(ClickType.PRACTITIONER),
      );
      //} else {
      // AppToast.showToast(message: 'Registration Fail');
      //}
    }
  }
}
