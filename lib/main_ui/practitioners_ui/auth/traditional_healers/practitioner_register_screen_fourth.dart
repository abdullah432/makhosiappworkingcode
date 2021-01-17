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
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

class PractiotnerRegisterScreenFourth extends StatefulWidget {
  Map<String, Object> _userData;

  PractiotnerRegisterScreenFourth(this._userData);

  @override
  _PractiotnerRegisterScreenFourthState createState() =>
      _PractiotnerRegisterScreenFourthState();
}

class _PractiotnerRegisterScreenFourthState
    extends State<PractiotnerRegisterScreenFourth>
    implements IRoundedButtonClicked, IOutlinedButtonClicked {
  var _uGhobelaController = TextEditingController();
  var _uGhobelaLocationController = TextEditingController();
  var _initiationTypeController = TextEditingController();
  var _trainingENdDateController = TextEditingController();
  var _ceremonyLocation = TextEditingController();

  bool _isLoading = false, _verificationAllowed = false;
  PickedFile _pickedFile;

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
    return ListView(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        _getBackButton(),
        Text(
          'Details about Training/Initiation',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        AppTextFields.getMultiLineRegisterField(
          controller: _uGhobelaController,
          label: 'uGhobela/inyanga name',
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            'If yes, please do not forget to list your products',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _uGhobelaLocationController,
          label: 'Location of uGhobela/inyanga',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _initiationTypeController,
          label: 'Initiation type you have done',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _trainingENdDateController,
          label: 'Training end date',
          isPassword: false,
          isNumber: true,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _ceremonyLocation,
          label: 'Homecoming ceremony location',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        _getPermissionSwitch(),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        _getUploadIdSection(),
        Others.getSizedBox(boxHeight: 32, boxWidth: 0),
        AppButtons.getRoundedButton(
          context: context,
          iRoundedButtonClicked: this,
          label: 'SIGN UP',
          clickType: ClickType.DUMMY,
        ),
      ],
    );
  }

  Widget _getUploadIdSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: AppButtons.getOutlineButton(
            context: context,
            iOutlinedButtonClicked: this,
            label: 'UPLOAD COPY OF ID',
            clickType: ClickType.DUMMY,
          ),
        ),
        Others.getSizedBox(boxHeight: 0, boxWidth: 8),
        Text(
          _pickedFile == null ? 'N/A' : 'Attached',
          style:
              TextStyle(color: _pickedFile == null ? Colors.red : Colors.green),
        ),
      ],
    );
  }

  Widget _getPermissionSwitch() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
            value: _verificationAllowed,
            onChanged: (val) {
              setState(() {
                _verificationAllowed = val;
              });
            }),
        Flexible(
          fit: FlexFit.tight,
          child: Text('Do you agree to full criminal check and verification?'),
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
              NavigationController.pushReplacement(
                  context, PractitionerRegisterScreenSecond(widget._userData));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          AppLabels.getLabel(
            labelText: 'SERVICE PROVIDER',
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

  @override
  onClick(ClickType clickType) async {
    String uGhobelaName = _uGhobelaController.text.trim();
    String uGhobelaLocation = _uGhobelaLocationController.text.trim();
    String initiationType = _initiationTypeController.text.trim();
    String trainingEndDate = _trainingENdDateController.text.trim();
    String ceremonyDate = _ceremonyLocation.text.trim();
    if (uGhobelaName.isEmpty) {
      AppToast.showToast(message: 'Please provide uGhobela name');
    } else if (uGhobelaLocation.isEmpty) {
      AppToast.showToast(message: 'Please provide uGhobela location');
    } else if (initiationType.isEmpty) {
      AppToast.showToast(message: 'Please provide type of your initiation');
    } else if (trainingEndDate.isEmpty) {
      AppToast.showToast(message: 'Training end date cannot be empty');
    } else if (ceremonyDate.isEmpty) {
      AppToast.showToast(message: 'Ceremony location cannot be empty');
    } else if (_pickedFile == null) {
      AppToast.showToast(message: 'Select ID first');
    } else {
      widget._userData.addAll({
        AppKeys.UGHOBELA_NAME: uGhobelaName,
        AppKeys.UGHOBELA_LOCATION: uGhobelaLocation,
        AppKeys.INITIATION_TYPE: initiationType,
        AppKeys.TRAINING_END_DATE: trainingEndDate,
        AppKeys.HOMECOMING_CEREMONY_LOCATION: ceremonyDate,
        AppKeys.VERIFICATION_ALLOWED: _verificationAllowed,
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
        bool firestoreResult = await helper.savePatientDataToFirestore(
          userInfoMap: widget._userData,
          userType: ClickType.PRACTITIONER,
        );
        if (firestoreResult) {
          bool imageUploadResult = await helper.uploadImage(
              pickedFile: _pickedFile, userType: ClickType.PRACTITIONER);
          if (imageUploadResult) {
            PreferencesHelper preferencesHelper = PreferencesHelper();
            await preferencesHelper.setUserType(ClickType.PRACTITIONER);
            AppToast.showToast(message: 'Registration success!');
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            NavigationController.pushReplacement(
                context, RegisterSuccessScreen(ClickType.PRACTITIONER));
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
  }

  @override
  void onOutlineButtonClicked(ClickType clickType) async {
    _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {});
  }
}
