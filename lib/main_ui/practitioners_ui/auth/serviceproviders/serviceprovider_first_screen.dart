import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/contracts/i_clickable_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/contracts/i_string_drop_down_item_selected.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/enums/field_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_second_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practiotoner_register_scree_third.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_clickable_fields.dart';
import 'package:makhosi_app/ui_components/app_dropdowns.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/ui_components/edit_hours_screen.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';

// ignore: must_be_immutable
class ServiceProviderRegisterScreenOne extends StatefulWidget {
  // Map<String, Object> _userData;
  // ServiceProviderRegisterScreenOne(this._userData);
  static var checkservice;

  ClickType _userType;
  ServiceProviderRegisterScreenOne(this._userType);

  @override
  _PractitionerRegisterScreenSecondState createState() =>
      _PractitionerRegisterScreenSecondState();
}

class _PractitionerRegisterScreenSecondState
    extends State<ServiceProviderRegisterScreenOne>
    implements IRoundedButtonClicked {
  var _buisnessNameController = TextEditingController();
  var _registrationNumController = TextEditingController();
  var _buisnessAddressController = TextEditingController();
  var _briefDescriptionController = TextEditingController();
  var _rulesController = TextEditingController();
  var _seub_service;
  //dropdown
  var _locationList = ['Home', 'Formal business premises'];
  String _selectedLocation;
  //service type
  var _serviceTypeList = StringConstants.SERVICES_LIST;
  String _selectedServiceType;
  //languages
  var _languagesList = StringConstants.LISTOFLANGUAGES;
  String _selectedLanguage;
  //formkey
  final _formKey = GlobalKey<FormState>();
  //location
  String _userCity;
  Location _location;
  Coordinates _userCoordinates;
  PermissionStatus _permissionStatus;

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
      _buisnessAddressController.text = addressList[0].addressLine;
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
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Text(
            'Details about Business',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          AppTextFields.getTextField(
            controller: _buisnessNameController,
            label: 'Preferred business name',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _registrationNumController,
            label: 'Company Registration No. (If available)',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //location dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Select Location'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedLocation,
              items: _locationList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedLocation = item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _buisnessAddressController,
            label: 'Address',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //services drop down
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Select Service Type'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedServiceType,
              items: _serviceTypeList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedServiceType = item;
                  ServiceProviderRegisterScreenOne.checkservice=item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child:
          DropdownButton(
            hint: Text('Select Sub Service'),
            isExpanded: true,
            underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
            value: _seub_service,
            items: _serviceTypeList
                .map(
                  (item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ),
            )
                .toList(),
            onChanged: (item) {
              setState(() {
                _seub_service = item;
                //ServiceProviderRegisterScreenOne.checkservice=item;
              });
            },
          ),
    ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getMultiLineRegisterField(
            controller: _briefDescriptionController,
            label: 'Brief Description of Service',
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getMultiLineRegisterField(
            controller: _rulesController,
            label: 'Business Rules',
          ),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          //languages drop down
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Select Language'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedLanguage,
              items: _languagesList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedLanguage = item;
                });
              },
            ),
          ),
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
            labelText: 'About Business',
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
    if (_formKey.currentState.validate()) {
      String business_name = _buisnessNameController.text.trim();
      String registration_no = _registrationNumController.text.trim();
      String business_address = _buisnessAddressController.text.trim();
      String business_description = _briefDescriptionController.text.trim();
      String business_rules = _rulesController.text.trim();
      if (_selectedLocation == null) {
        AppToast.showToast(message: 'Please select location');
      } else if (_selectedServiceType == null) {
        AppToast.showToast(message: 'Please select service type');
      } else if (_selectedLanguage.isEmpty) {
        AppToast.showToast(message: 'Please select language');
      } else {
        NavigationController.push(
          context,
          ServiceProviderRegisterScreenTwo({
            AppKeys.PREFERED_BUISNESS_NAME: business_name,
            AppKeys.COMPANY_REGISTRATION_NO: registration_no,
            AppKeys.BUISNESS_LOCATION_TYPE: _selectedLocation,
            AppKeys.SERVICE_BRIEF_DESCRIPTION: business_description,
            AppKeys.BUISNESS_RULES: business_rules,
            AppKeys.ADDRESS: business_address,
            AppKeys.SERVICE_TYPE: _selectedServiceType,
            AppKeys.LANGUAGES: _selectedLanguage,
            AppKeys.PRACTICE_CITY: _userCity,
            AppKeys.COORDINATES: {
              AppKeys.LATITUDE: _userCoordinates.latitude,
              AppKeys.LONGITUDE: _userCoordinates.longitude,
            },
            // AppKeys.TIMINGS: {
            //   AppKeys.SUNDAY_OPEN: _timingModel.sundayStart,
            //   AppKeys.SUNDAY_CLOSE: _timingModel.sundayEnd,
            //   AppKeys.MONDAY_OPEN: _timingModel.mondayStart,
            //   AppKeys.MONDAY_CLOSE: _timingModel.mondayEnd,
            //   AppKeys.TUESDAY_OPEN: _timingModel.tuesdayStart,
            //   AppKeys.TUESDAY_CLOSE: _timingModel.tuesdayEnd,
            //   AppKeys.WEDNESDAY_OPEN: _timingModel.wednesdayStart,
            //   AppKeys.WEDNESDAY_CLOSE: _timingModel.wednesdayEnd,
            //   AppKeys.THURSDAY_OPEN: _timingModel.thursdayStart,
            //   AppKeys.THURSDAY_CLOSE: _timingModel.thursdayEnd,
            //   AppKeys.FRIDAY_OPEN: _timingModel.fridayStart,
            //   AppKeys.FRIDAY_CLOSE: _timingModel.fridayEnd,
            //   AppKeys.SATURDAY_OPEN: _timingModel.saturdayStart,
            //   AppKeys.SATURDAY_CLOSE: _timingModel.saturdayEnd,
            // },
          }),
        );
      }
    }

    @override
    void onItemStringDropDownItemSelected(String selectedItem) {
      setState(() {
        _selectedLocation = selectedItem;
      });
    }
  }
}
