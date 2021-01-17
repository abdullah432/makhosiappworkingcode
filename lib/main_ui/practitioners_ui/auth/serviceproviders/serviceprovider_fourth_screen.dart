import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/helpers/auth/register/register_helper.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/register_success_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/ui_components/settings/terms_policy.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class ServiceProviderFourthScreen extends StatefulWidget {
  Map<String, Object> _userData;
  PickedFile pickedFile;
  ServiceProviderFourthScreen(this._userData, this.pickedFile);

  @override
  _PractiotnerRegisterScreenFourthState createState() =>
      _PractiotnerRegisterScreenFourthState();
}

class _PractiotnerRegisterScreenFourthState
    extends State<ServiceProviderFourthScreen>
    implements IRoundedButtonClicked {
  var _additionalServiceController = TextEditingController();

  bool _isLoading = false, _verificationAllowed = false;
  PickedFile _pickedFile;
  //check box parameters
  bool isBuisnessOwner = false;
  bool understandGuidliness = true;
  bool ownBuisness = false;

  @override
  Widget build(BuildContext context) {
    print(widget._userData);
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
    return ListView(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        _getBackButton(),
        Text(
          'Additional',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        //do you have business owner check boxes
        CheckboxListTile(
          title: Text(
            "Are you the Business Owner?",
            style: TextStyle(fontSize: 15.0),
          ),
          value: isBuisnessOwner,
          onChanged: (newValue) {
            setState(() {
              isBuisnessOwner = newValue;
            });
          },
          controlAffinity:
              ListTileControlAffinity.trailing, //  <-- leading Checkbox
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        //do you have business owner check boxes
        CheckboxListTile(
          title: Text(
            "I understand Mkhosi’s Community Guidelines",
            style: TextStyle(fontSize: 15.0),
          ),
          value: understandGuidliness,
          onChanged: (newValue) {
            setState(() {
              understandGuidliness = newValue;
            });
          },
          controlAffinity:
              ListTileControlAffinity.trailing, //  <-- leading Checkbox
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        //warning
        RichText(
          // textAlign: TextAlign.right,
          text: new TextSpan(
            text: 'By selecting yes you are required to act according to the ',
            // style: DefaultTextStyle.of(context).style,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: <TextSpan>[
              new TextSpan(
                text: 'Mkhosi Community Guidelines.',
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
              new TextSpan(
                  text:
                  ' Failure to do so will result in the deactivation of your account and possible criminal charges'),
            ],
          ),
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        //do you have delivery service check boxes
        CheckboxListTile(
          title: Text(
            "Do you own any other business?",
            style: TextStyle(fontSize: 15.0),
          ),
          value: ownBuisness,
          onChanged: (newValue) {
            setState(() {
              ownBuisness = newValue;
            });
          },
          controlAffinity:
              ListTileControlAffinity.trailing, //  <-- leading Checkbox
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        Visibility(
          visible: true,
          child: AppTextFields.getTextField(
            controller: _additionalServiceController,
            label: 'Choose additional service...',
            isPassword: false,
            isNumber: false,
          ),
        ),

        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppButtons.getRoundedButton(
          context: context,
          iRoundedButtonClicked: this,
          label: 'SIGN UP',
          clickType: ClickType.DUMMY,
        ),
      ],
    );
  }

  Widget _getBackButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
            labelText: 'Personal Info',
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

// var _additionalServiceController = TextEditingController();

//   bool _isLoading = false, _verificationAllowed = false;
//   PickedFile _pickedFile;
//   //check box parameters
//   bool isBuisnessOwner = false;
//   bool understandGuidliness = true;
//   bool ownBuisness = false;
  @override
  onClick(ClickType clickType) async {
    // print('service type: ' + widget._userData[AppKeys.SERVICE_TYPE].toString());
    String additional_services = _additionalServiceController.text.trim();
    if (!understandGuidliness) {
      AppToast.showToast(message: 'Pleases agree with community guideliness');
    } else {
      widget._userData.addAll({
        AppKeys.BUSINESS_OWNER: ownBuisness,
        AppKeys.OTHER_BUSINESS_OWNER: ownBuisness,
        AppKeys.ADDITIONAL_SERVICES: additional_services,
      });
      RegisterHelper helper = RegisterHelper();
      setState(() {
        _isLoading = true;
      });
      bool registerStatus = await helper.registerUser(
        email: widget._userData[AppKeys.EMAIL],
        password: widget._userData[AppKeys.PASSWORD],
      );
      if (registerStatus) {
        //upload id image first
print(widget._userData);
        bool firestoreResult = await helper.savePatientDataToFirestore2(
          userInfoMap: widget._userData,
          //userType: ClickType.PRACTITIONER,
        );
        if (firestoreResult) {
          bool imageUploadResult = await helper.uploadImage(
            pickedFile: widget.pickedFile,
            userType: ClickType.PRACTITIONER,
          );
          if (imageUploadResult) {
            PreferencesHelper preferencesHelper = PreferencesHelper();
            await preferencesHelper.setUserType(ClickType.PRACTITIONER);
            AppToast.showToast(message: 'Registration success!');
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);

            NavigationController.pushReplacement(
                context,
                RegisterSuccessScreen(
                  ClickType.PRACTITIONER,
                  serviceType:
                      widget._userData[AppKeys.SERVICE_TYPE].toString(),
                ));
          } else {
            setState(() {
              _isLoading = false;
              AppToast.showToast(
                  message: 'There was an error saving your ID image');
            });
          }
        } else {
          setState(() {
            _isLoading = false;
            AppToast.showToast(message: 'There was an error saving your data');
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          AppToast.showToast(
              message: 'There was an error registering this practitioner');
        });
      }
    }

    // Navigator.pop(context);
    //         Navigator.pop(context);
    //         Navigator.pop(context);
    // NavigationController.pushReplacement(
    //     context, RegisterSuccessScreen(ClickType.PRACTITIONER));
  }
}
