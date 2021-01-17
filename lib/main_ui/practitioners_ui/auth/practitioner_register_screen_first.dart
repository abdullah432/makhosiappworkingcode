import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/contracts/i_string_drop_down_item_selected.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_dropdowns.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';

// ignore: must_be_immutable
class PractitionerRegisterScreenFirst extends StatefulWidget {
  ClickType _userType;

  PractitionerRegisterScreenFirst(this._userType);

  @override
  _PractitionerRegisterScreenFirstState createState() =>
      _PractitionerRegisterScreenFirstState();
}

class _PractitionerRegisterScreenFirstState
    extends State<PractitionerRegisterScreenFirst>
    implements IRoundedButtonClicked, IStringDropDownItemSelected {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _idNumberController = TextEditingController();
  var _dloziNameController = TextEditingController();
  var _yearsPracticingController = TextEditingController();
  var _languagesController = TextEditingController();
  var _associationController = TextEditingController();
  var _locationController = TextEditingController();
  String _userCity;
  Location _location;
  Coordinates _userCoordinates;
  PermissionStatus _permissionStatus;
  var _genderList = ['Select Gender', 'Male', 'Female', 'Other'];
  String _selectedGender = StringConstants.SELECTED_GENDER;

  @override
  void initState() {
    _location = Location();
    _checkLocationPermissions();
    super.initState();
  }

  Future<void> _checkLocationPermissions() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied)
      _permissionStatus = await _location.requestPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      AppToast.showToast(message: 'Permission denied');
      return;
    }
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    LocationData locationData = await _location.getLocation();
    _userCoordinates =
        Coordinates(locationData.latitude, locationData.longitude);
    _getUserAddress();
  }

  Future<void> _getUserAddress() async {
    List<Address> addressList =
        await Geocoder.local.findAddressesFromCoordinates(_userCoordinates);
    if (addressList.isNotEmpty) {
      _locationController.text = addressList[0].addressLine;
      _userCity = addressList[0].subAdminArea;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        NavigationController.pushReplacement(
          context,
          LoginScreen(widget._userType),
        );
      },
      child: Scaffold(
        body: _getForm(),
      ),
    );
  }

  Widget _getForm() {
    return ListView(
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
        AppTextFields.getTextField(
          controller: _idNumberController,
          label: 'ID Number/Passport Number',
          isPassword: false,
          isNumber: true,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _dloziNameController,
          label: 'Dlozi Name',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppDropDowns.getBorderedStringDropDown(
          this,
          _selectedGender,
          _genderList,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _yearsPracticingController,
          label: 'Years Practicing',
          isPassword: false,
          isNumber: true,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _languagesController,
          label: 'Languages',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _locationController,
          label: 'Practice Location',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _associationController,
          label: 'Do you belong to an association?',
          isPassword: false,
          isNumber: false,
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text('If yes, please provide Registration ID'),
        ),
        Others.getSizedBox(boxHeight: 32, boxWidth: 0),
        AppButtons.getRoundedButton(
          context: context,
          iRoundedButtonClicked: this,
          label: 'NEXT',
          clickType: ClickType.DUMMY,
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
              NavigationController.pushReplacement(
                  context, LoginScreen(widget._userType));
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
  onClick(ClickType clickType) {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String idNumber = _idNumberController.text.trim();
    String dloziName = _dloziNameController.text.trim();
    String yearsPracticing = _yearsPracticingController.text.trim();
    String languages = _languagesController.text.trim();
    String practiceLocation = _locationController.text.trim();
    String associationNumber = _associationController.text.trim();
    if (firstName.isEmpty) {
      AppToast.showToast(message: 'First name cannot be empty');
    } else if (lastName.isEmpty) {
      AppToast.showToast(message: 'Last name cannot be empty');
    } else if (email.isEmpty) {
      AppToast.showToast(message: 'Email cannot be empty');
    } else if (password.isEmpty) {
      AppToast.showToast(message: 'Password cannot be empty');
    } else if (password.length < 6) {
      AppToast.showToast(
          message: 'Password cannot be less tan 6 be characters');
    } else if (idNumber.isEmpty) {
      AppToast.showToast(message: 'ID number cannot be empty');
    } else if (dloziName.isEmpty) {
      AppToast.showToast(message: 'Dlozi name cannot be empty');
    } else if (yearsPracticing.isEmpty) {
      AppToast.showToast(message: 'Practice years cannot be empty');
    } else if (languages.isEmpty) {
      AppToast.showToast(message: 'Languages cannot be empty');
    } else if (practiceLocation.isEmpty) {
      AppToast.showToast(message: 'Practice location cannot be empty');
    } else {
      NavigationController.push(
        context,
        PractitionerRegisterScreenSecond(
          {
            AppKeys.FIRST_NAME: firstName,
            AppKeys.SECOND_NAME: lastName,
            AppKeys.EMAIL: email,
            AppKeys.PASSWORD: password,
            AppKeys.ID_NUMBER: idNumber,
            AppKeys.ONLINE: true,
            AppKeys.DLOZI_NAME: dloziName,
            AppKeys.PRACTICE_YEARS: yearsPracticing,
            AppKeys.LANGUAGES: languages,
            AppKeys.PROFILE_IMAGE: null,
            AppKeys.PRACTICE_LOCATION: practiceLocation,
            AppKeys.ASSOCIATION_NUMBER: associationNumber,
            AppKeys.PRACTICE_CITY: _userCity,
            AppKeys.COORDINATES: {
              AppKeys.LATITUDE: _userCoordinates.latitude,
              AppKeys.LONGITUDE: _userCoordinates.longitude
            },
          },
        ),
      );
    }
  }

  @override
  void onItemStringDropDownItemSelected(String selectedItem) {
    setState(() {
      _selectedGender = selectedItem;
    });
  }
}
