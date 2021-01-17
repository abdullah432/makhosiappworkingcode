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
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_clickable_fields.dart';
import 'package:makhosi_app/ui_components/app_dropdowns.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/ui_components/edit_hours_screen.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceProviderUpdateScreen extends StatefulWidget {
  @override
  _PatientRegisterScreenState2 createState() => _PatientRegisterScreenState2();
}

class _PatientRegisterScreenState2 extends State<ServiceProviderUpdateScreen>
    implements IRoundedButtonClicked, IClickableClicked {
  var _firstnameController = TextEditingController();
  var _lastnameController = TextEditingController();
  var _buisnessNameController = TextEditingController();
  var _buisnessRulesController = TextEditingController();
  var _consultationFeeController = TextEditingController();
  var _addressController = TextEditingController();
  RegisterHelper _registerHelper = RegisterHelper();
  PreferencesHelper _preferencesHelper = PreferencesHelper();
  bool _isLoading = false;
  String _selectedLocation;
  Location _location;
  Coordinates _userCoordinates;
  PermissionStatus _permissionStatus;
  DocumentSnapshot _userProfileSnapshot;
  String _uid;
  TimingModel _timingModel;

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
    print('_uid: ' + _uid.toString());
    _userProfileSnapshot = await FirebaseFirestore.instance
        .collection('service_provider')
        .doc(_uid)
        .get();
    setState(() {
      _firstnameController.text = _userProfileSnapshot.get(AppKeys.FIRST_NAME);
      _lastnameController.text = _userProfileSnapshot.get(AppKeys.LAST_NAME);
      _buisnessNameController.text =
          _userProfileSnapshot.get(AppKeys.PREFERED_BUISNESS_NAME);
      _buisnessRulesController.text =
          _userProfileSnapshot.get(AppKeys.BUISNESS_RULES);
      _consultationFeeController.text =
          _userProfileSnapshot.get(AppKeys.CONSULTATION_FEE_PER_SESSION);
      // _timingModel.sundayStart =
      //     _userProfileSnapshot.data()[AppKeys.TIMINGS][AppKeys.SUNDAY_OPEN];
      // print(_userProfileSnapshot.get(AppKeys.TIMINGS).toString());
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
          controller: _firstnameController,
          label: 'First Name',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _lastnameController,
          label: 'Last Name',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _buisnessNameController,
          label: 'Buisness Name',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        // Others.getSizedBox(
        //     boxHeight: _userProfileSnapshot == null ? 16 : 0, boxWidth: 0),
        // _userProfileSnapshot == null
        //     ? AppTextFields.getTextField(
        //         controller: _emailController,
        //         label: 'Email',
        //         isPassword: false,
        //         isNumber: false,
        //       )
        //     : Container(),
        // Others.getSizedBox(
        //     boxHeight: _userProfileSnapshot == null ? 16 : 0, boxWidth: 0),
        // _userProfileSnapshot == null
        //     ? AppTextFields.getTextField(
        //         controller: _passwordController,
        //         label: 'Password',
        //         isPassword: true,
        //         isNumber: false,
        //       )
        //     : Container(),
        // Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        // AppTextFields.getTextField(
        //   controller: _phoneNumberController,
        //   label: 'Phone Number',
        //   isPassword: false,
        //   isNumber: true,
        // ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _addressController,
          label: 'Address',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getMultiLineRegisterField(
          controller: _buisnessNameController,
          label: 'Buisness Rules',
        ),
        // Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        // AppClickableFields.getBorderedClickableField(
        //   _timingModel == null
        //       ? 'Business Operating Hours'
        //       : 'Selected ${_timingModel.mondayStart}.....',
        //   FieldType.TIME,
        //   this,
        //   Icons.watch,
        // ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
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
  onClick(ClickType clickType) async {
    String firstname = _firstnameController.text.trim();
    String lastname = _lastnameController.text.trim();
    String buisnessname = _buisnessNameController.text.trim();
    String buisnessrules = _buisnessRulesController.text.trim();
    String fees = _consultationFeeController.text.trim();
    // String phoneNumber = _phoneNumberController.text.trim();
    // String dateOfBirth = _dateOfBirth;
    // String gender = _selectedGender;
    if (firstname.isEmpty) {
      AppToast.showToast(message: 'First Name cannot be empty');
    } else if (lastname.isEmpty) {
      AppToast.showToast(message: 'Last Name cannot be empty');
    } else if (buisnessname.isEmpty) {
      AppToast.showToast(message: 'Phone number cannot be empty');
    } else if (buisnessrules.isEmpty) {
      AppToast.showToast(message: 'Address cannot be empty');
    }
    // else if (_timingModel == null) {
    //   AppToast.showToast(message: 'Please select business operating hours');
    // }
    else {
      setState(() {
        _isLoading = true;
      });
      FirebaseFirestore.instance
          .collection('service_provider')
          .doc(_userProfileSnapshot.id)
          .update(
        {
          AppKeys.FIRST_NAME: firstname,
          AppKeys.LAST_NAME: lastname,
          AppKeys.PREFERED_BUISNESS_NAME: buisnessname,
          AppKeys.BUISNESS_RULES: buisnessrules,
          AppKeys.CONSULTATION_FEE_PER_SESSION: fees,
        },
      ).then((_) async {
        var snapshot = await FirebaseFirestore.instance
            .collection('service_provider')
            .doc(_userProfileSnapshot.id)
            .get();
        Navigator.pop(context);
        // NavigationController.pushReplacement(
        //   context,
        //   PractitionersProfileScreen(false, snapshot),
        // );
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          AppToast.showToast(message: error.toString());
        });
      });
    }
  }

  @override
  void onFieldClicked(FieldType fieldType) async {
    _timingModel = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditHoursScreen(),
      ),
    );
    setState(() {});
  }
}
