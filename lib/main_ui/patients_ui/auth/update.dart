import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_clickable_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/contracts/i_string_drop_down_item_selected.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/enums/field_type.dart';
import 'package:makhosi_app/helpers/auth/register/register_helper.dart';
import 'package:makhosi_app/helpers/others/date_time_helper.dart';
import 'package:makhosi_app/helpers/others/preferences_helper.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/general_ui/register_success_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/profile_screens/patient_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_clickable_fields.dart';
import 'package:makhosi_app/ui_components/app_dropdowns.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientRegisterScreen2 extends StatefulWidget {
  @override
  _PatientRegisterScreenState2 createState() => _PatientRegisterScreenState2();
}

class _PatientRegisterScreenState2 extends State<PatientRegisterScreen2>
    implements
        IStringDropDownItemSelected,
        IClickableClicked,
        IRoundedButtonClicked {
  var _nameController = TextEditingController();
  var _addressController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _genderList = ['Select Gender', 'Male', 'Female', 'Other'];
  String _selectedGender = StringConstants.SELECTED_GENDER;
  String _dateOfBirth = StringConstants.DATE_OF_BIRTH;
  DateTimeHelper _dateTimeHelper = DateTimeHelper();
  RegisterHelper _registerHelper = RegisterHelper();
  PreferencesHelper _preferencesHelper = PreferencesHelper();
  bool _isLoading = false;
  String _selectedLocation;
  Location _location;
  Coordinates _userCoordinates;
  PermissionStatus _permissionStatus;
  DocumentSnapshot _userProfileSnapshot;
  String _uid;

  @override
  void initState() {
    _getUserProfileData();

    super.initState();
    _location = Location();
    _checkLocationPermissions();
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
      _addressController.text = addressList[0].addressLine;
      //_userCity = addressList[0].subAdminArea;
    }
  }

  Future<void> _getUserProfileData() async {
    _uid = FirebaseAuth.instance.currentUser.uid;
    _userProfileSnapshot =
        await FirebaseFirestore.instance.collection('patients').doc(_uid).get();
    setState(() {
      _nameController.text = _userProfileSnapshot.get(AppKeys.FULL_NAME);
      _phoneNumberController.text =
          _userProfileSnapshot.get(AppKeys.PHONE_NUMBER);
      _addressController.text = _userProfileSnapshot.get(AppKeys.ADDRESS);
      _selectedGender = _userProfileSnapshot.get(AppKeys.GENDER);
      _dateOfBirth = _userProfileSnapshot.get(AppKeys.DATE_OF_BIRTH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Stack(
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
      padding: EdgeInsets.all(32),
      children: [
        _getBackButton(),
        Text(
          'Personal Info',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _nameController,
          label: 'Full Name',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(
            boxHeight: _userProfileSnapshot == null ? 16 : 0, boxWidth: 0),
        _userProfileSnapshot == null
            ? AppTextFields.getTextField(
                controller: _emailController,
                label: 'Email',
                isPassword: false,
                isNumber: false,
              )
            : Container(),
        Others.getSizedBox(
            boxHeight: _userProfileSnapshot == null ? 16 : 0, boxWidth: 0),
        _userProfileSnapshot == null
            ? AppTextFields.getTextField(
                controller: _passwordController,
                label: 'Password',
                isPassword: true,
                isNumber: false,
              )
            : Container(),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _phoneNumberController,
          label: 'Phone Number',
          isPassword: false,
          isNumber: true,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _addressController,
          label: 'Address',
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
        AppClickableFields.getBorderedClickableField(
          _dateOfBirth,
          FieldType.DATE,
          this,
          Icons.calendar_today,
        ),
        Others.getSizedBox(boxHeight: 32, boxWidth: 0),
        AppButtons.getRoundedButton(
          context: context,
          iRoundedButtonClicked: this,
          label: _userProfileSnapshot == null ? 'SIGN UP' : 'SAVE',
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
                context,
                PatientProfileScreen(_userProfileSnapshot, false),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          AppLabels.getLabel(
            labelText:
                _userProfileSnapshot == null ? 'CUSTOMER' : 'EDIT PROFILE',
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
  void onItemStringDropDownItemSelected(String selectedItem) {
    setState(() {
      _selectedGender = selectedItem;
    });
  }

  @override
  void onFieldClicked(FieldType fieldType) async {
    switch (fieldType) {
      case FieldType.DATE:
        _dateOfBirth =
            await _dateTimeHelper.openDatePicker(context, _dateOfBirth);
        setState(() {});
        break;
    }
  }

  @override
  onClick(ClickType clickType) async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String address = _addressController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String dateOfBirth = _dateOfBirth;
    String gender = _selectedGender;
    if (_userProfileSnapshot == null) {
      bool isValidUser = _registerHelper.validateUser(
        name: name,
        email: email,
        password: password,
        address: address,
        phone: phoneNumber,
        selectedGender: _selectedGender,
        dateOfBirth: _dateOfBirth,
      );
      if (isValidUser) {
        setState(() {
          _isLoading = true;
        });
        bool isRegisterSuccess = await _registerHelper.registerUser(
          email: email,
          password: password,
        );
        if (isRegisterSuccess) {
          bool isSaveSuccess = await _registerHelper.savePatientDataToFirestore(
            userInfoMap: {
              AppKeys.FULL_NAME: name,
              AppKeys.EMAIL: email,
              AppKeys.ADDRESS: address,
              AppKeys.PHONE_NUMBER: phoneNumber,
              AppKeys.GENDER: _selectedGender,
              AppKeys.DATE_OF_BIRTH: _dateOfBirth,
              AppKeys.PROFILE_IMAGE: null,
            },
          );
          if (isSaveSuccess) {
            NavigationController.pushReplacement(
                context, RegisterSuccessScreen(ClickType.PATIENT));
          } else {
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if (name.isEmpty) {
        AppToast.showToast(message: 'Name cannot be empty');
      } else if (phoneNumber.isEmpty) {
        AppToast.showToast(message: 'Phone number cannot be empty');
      } else if (address.isEmpty) {
        AppToast.showToast(message: 'Address cannot be empty');
      } else {
        setState(() {
          _isLoading = true;
        });
        FirebaseFirestore.instance
            .collection('patients')
            .doc(_userProfileSnapshot.id)
            .update(
          {
            AppKeys.FULL_NAME: name,
            AppKeys.ADDRESS: address,
            AppKeys.PHONE_NUMBER: phoneNumber,
            AppKeys.DATE_OF_BIRTH: dateOfBirth,
            AppKeys.GENDER: gender,
          },
        ).then((_) async {
          var snapshot = await FirebaseFirestore.instance
              .collection('patients')
              .doc(_userProfileSnapshot.id)
              .get();
          NavigationController.pushReplacement(
            context,
            PatientProfileScreen(snapshot, false),
          );
        }).catchError((error) {
          setState(() {
            _isLoading = false;
            AppToast.showToast(message: error.toString());
          });
        });
      }
    }
  }
}
