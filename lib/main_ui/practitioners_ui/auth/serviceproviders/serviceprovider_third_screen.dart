import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_fourth_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

// ignore: must_be_immutable
class ServiceProviderPersonalDetailScreen extends StatefulWidget {
  Map<String, Object> _userData;
  ServiceProviderPersonalDetailScreen(this._userData);

  @override
  _PractitionerRegisterScreenFirstState createState() =>
      _PractitionerRegisterScreenFirstState();
}

class _PractitionerRegisterScreenFirstState
    extends State<ServiceProviderPersonalDetailScreen>
    implements IRoundedButtonClicked, IOutlinedButtonClicked {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _idNumberController = TextEditingController();
  Country _selectedCountry = Country.ZA;
  //dropdown
  var _identificationTypeList = ['Passport', 'ID'];
  String _selectedIdentificationType;
  //verification document
  bool _isLoading = false, _verificationAllowed = true;
  PickedFile _pickedFile;
  //formkey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // _location = Location();
    // _checkLocationPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getForm(),
    );
  }

  Widget _getForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Text(
            'Personal Info',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          AppTextFields.getTextField(
            controller: _firstNameController,
            label: 'Legal First Name',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _lastNameController,
            label: 'Legal Last Name',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //Business Practice dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: CountryPicker(
              dense: false,
              // showFlag: true, //displays flag, true by default
              // showDialingCode: false, //displays dialing code, false by default
              // showName: true, //displays country name, true by default
              // showCurrency: false, //eg. 'British pound'
              // showCurrencyISO: true, //eg. 'GBP'
              onChanged: (Country country) {
                setState(() {
                  _selectedCountry = country;
                });
              },
              selectedCountry: _selectedCountry,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //Business Practice dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Type of identification'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedIdentificationType,
              items: _identificationTypeList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedIdentificationType = item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _idNumberController,
            label: 'ID Number/Passport Number',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _emailController,
            label: 'Email',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _passwordController,
            label: 'Password',
            isPassword: true,
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
            label: 'NEXT',
            clickType: ClickType.DUMMY,
          ),
        ],
      ),
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

      ],
    );
  }

  Widget _getPermissionSwitch() {
    return Column(children: [
      Row(
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
            child: RichText(
              text: new TextSpan(
                text: 'Do you agree to full ',
                style: TextStyle(
                  color: Colors.black54,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'criminal check',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new TextSpan(text: ' and'),
                  TextSpan(
                      text: ' verification?',
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Text('Do you agree to full criminal check and verification?'),
          ),
        ],
      ),
//
      Text(
        '*Please note this verification will take about 5 days',
        style: TextStyle(color: Colors.black54),
      ),
    ]);
  }

  Widget _getBackButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // NavigationController.pushReplacement(
              //     context, LoginScreen(widget._userType));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          AppLabels.getLabel(
            labelText: 'Personal Details',
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

// var _emailController = TextEditingController();
//   var _passwordController = TextEditingController();
//   var _firstNameController = TextEditingController();
//   var _lastNameController = TextEditingController();
//   var _idNumberController = TextEditingController();
//   Country _selectedCountry = Country.ZA;
//   //dropdown
//   var _identificationTypeList = ['Password', 'ID'];
//   String _selectedIdentificationType;
//   //verification document
//   bool _isLoading = false, _verificationAllowed = true;
//   PickedFile _pickedFile;

  @override
  onClick(ClickType clickType) {
    if (_formKey.currentState.validate()) {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String idNumber = _idNumberController.text.trim();
      if (_selectedIdentificationType == null) {
        AppToast.showToast(message: 'Please select indentification type');
      } else if (!_verificationAllowed) {
        AppToast.showToast(message: 'Please agree with our rules');
      } else if (_pickedFile == null) {
        AppToast.showToast(message: 'Link id picture');
      } else {
        widget._userData.addAll({
          AppKeys.FIRST_NAME: firstName,
          AppKeys.LAST_NAME: lastName,
          AppKeys.COUNTRY: _selectedCountry.name,
          AppKeys.TYPE_OF_IDENTIFICATION: _selectedIdentificationType,
          AppKeys.IDENTIFICATION_NUMBER: idNumber,
          AppKeys.EMAIL: email,
          AppKeys.PASSWORD: password,
          AppKeys.VERIFICATION_ALLOWED: _verificationAllowed,
        });

        NavigationController.push(
          context,
          ServiceProviderFourthScreen(
            widget._userData,
            _pickedFile,
          ),
        );
      }
    }
  }

  @override
  void onOutlineButtonClicked(ClickType clickType) async {
    _pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {});
  }
}
