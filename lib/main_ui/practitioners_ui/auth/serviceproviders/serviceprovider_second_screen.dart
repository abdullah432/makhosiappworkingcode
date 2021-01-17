import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_clickable_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/enums/field_type.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_third_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practiotoner_register_scree_third.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_clickable_fields.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/ui_components/edit_hours_screen.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_first_screen.dart';
import 'package:makhosi_app/utils/string_constants.dart';

// ignore: must_be_immutable
class ServiceProviderRegisterScreenTwo extends StatefulWidget {
  Map<String, Object> _userData;

  ServiceProviderRegisterScreenTwo(this._userData);

  @override
  _PractitionerRegisterScreenSecondState createState() =>
      _PractitionerRegisterScreenSecondState();
}

class _PractitionerRegisterScreenSecondState
    extends State<ServiceProviderRegisterScreenTwo>
    implements IRoundedButtonClicked, IClickableClicked {
  var _yearsInPracticeController = TextEditingController();
  var _websiteLinkController = TextEditingController();
  var _socialMediaUsernameControllerInstagram = TextEditingController();
  var _socialMediaUsernameControllerLinkedIn = TextEditingController();
  var _socialMediaUsernameControllerFacebook = TextEditingController();
  var _socialMediaUsernameControllerWhatsapp = TextEditingController();

  var _deliveryPriceController = TextEditingController();
  var _consultationFeeController = TextEditingController();
  TimingModel _timingModel;
  //dropdown data
  var _businessPracticeList = ['Physical', 'Virtual', 'Both'];
  String _selectedPractice;
  var _paymentTypeList = ['Cash', 'Online', 'Both'];
  String _selectedPaymentType;
  //checkbox
  bool isBuisnessWebsite = false;
  bool isSocialMediaInsta = false,
      isSocialMediaLinkedIn = false,
      isSocialMediaFb = false,
      isSocialMediaWhatsapp = false;
  bool isDelivery = false;
  bool sickNote = false, invoice = false, quotation = false;
  //formkey
  final _formKey = GlobalKey<FormState>();

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
        shrinkWrap: true,
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Text(
            'Details about Business (continued)',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          //Business Practice dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Business Practice'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedPractice,
              items: _businessPracticeList
                  .map(
                    (item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                ),
              )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedPractice = item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _yearsInPracticeController,
            label: 'Years in Operations',
            isPassword: false,
            isNumber: true,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //do you have website check boxes
          CheckboxListTile(
            title: Text(
              "Do you have a company website",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isBuisnessWebsite,
            onChanged: (newValue) {
              setState(() {
                isBuisnessWebsite = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isBuisnessWebsite,
            child: AppTextFields.getTextField(
              controller: _websiteLinkController,
              label: 'Please provide a website',
              isPassword: false,
              isNumber: false,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //do you have social media check boxes
          CheckboxListTile(
            title: Text(
              "Do you have instagram account?",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isSocialMediaInsta,
            onChanged: (newValue) {
              setState(() {
                isSocialMediaInsta = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isSocialMediaInsta,
            child: AppTextFields.getTextField(
              controller: _socialMediaUsernameControllerInstagram,
              label: 'Please enter instagram account username',
              isPassword: false,
              isNumber: false,
            ),
          ),
          // Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          // AppTextFields.getTextField(
          //   controller: _sessionTimeController,
          //   label: 'Business Operating Hours',
          //   isPassword: false,
          //   isNumber: false,
          // ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          CheckboxListTile(
            title: Text(
              "Do you have linkedIn account?",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isSocialMediaLinkedIn,
            onChanged: (newValue) {
              setState(() {
                isSocialMediaLinkedIn = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isSocialMediaLinkedIn,
            child: AppTextFields.getTextField(
              controller: _socialMediaUsernameControllerLinkedIn,
              label: 'Please enter linkedIn account url',
              isPassword: false,
              isNumber: false,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          CheckboxListTile(
            title: Text(
              "Do you have Facebook account?",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isSocialMediaFb,
            onChanged: (newValue) {
              setState(() {
                isSocialMediaFb = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isSocialMediaFb,
            child: AppTextFields.getTextField(
              controller: _socialMediaUsernameControllerFacebook,
              label: 'Please enter facebook account url',
              isPassword: false,
              isNumber: false,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          CheckboxListTile(
            title: Text(
              "Do you have Whatsapp account?",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isSocialMediaWhatsapp,
            onChanged: (newValue) {
              setState(() {
                isSocialMediaWhatsapp = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isSocialMediaWhatsapp,
            child: AppTextFields.getTextField(
              controller: _socialMediaUsernameControllerWhatsapp,
              label: 'Please enter your whatsapp number',
              isPassword: false,
              isNumber: false,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //do you have delivery service check boxes
          CheckboxListTile(
            title: Text(
              "Do you deliver?",
              style: TextStyle(fontSize: 15.0),
            ),
            value: isDelivery,
            onChanged: (newValue) {
              setState(() {
                isDelivery = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.trailing, //  <-- leading Checkbox
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Visibility(
            visible: isDelivery,
            child: AppTextFields.getTextField(
              controller: _deliveryPriceController,
              label: 'Delivery Price (ZAR)',
              isPassword: false,
              isNumber: true,
            ),
          ),

          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppClickableFields.getBorderedClickableField(
            _timingModel == null
                ? 'Business Operating Hours'
                : 'Selected ${_timingModel.mondayStart}.....',
            FieldType.TIME,
            this,
            Icons.watch,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _consultationFeeController,
            label: 'Consultation Fee per session (ZAR)',
            isPassword: false,
            isNumber: true,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          //Payment Accepted dropdown
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text('Payment Accepted?'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedPaymentType,
              items: _paymentTypeList
                  .map(
                    (item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                ),
              )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedPaymentType = item;
                });
              },
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text('Client  Adminstration Support'),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //first
              ServiceProviderRegisterScreenOne.checkservice == 'Abelaphi'
                  ? Flexible(
                child: CheckboxListTile(
                  title: Text(
                    "Sick Notes",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: sickNote,
                  onChanged: (newValue) {
                    setState(() {
                      sickNote = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .trailing, //  <-- leading Checkbox
                ),
              )
                  : Text(''),
              //second
              Flexible(
                child: CheckboxListTile(
                  title: Text(
                    "Invoices",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: invoice,
                  onChanged: (newValue) {
                    setState(() {
                      invoice = newValue;
                    });
                  },
                  controlAffinity:
                  ListTileControlAffinity.trailing, //  <-- leading Checkbox
                ),
              ),
              //third
              Flexible(
                child: CheckboxListTile(
                  title: Text(
                    "Quotations",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: quotation,
                  onChanged: (newValue) {
                    setState(() {
                      quotation = newValue;
                    });
                  },
                  controlAffinity:
                  ListTileControlAffinity.trailing, //  <-- leading Checkbox
                ),
              ),
            ],
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
              Navigator.pop(context);
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

  // var _yearsInPracticeController = TextEditingController();
  // var _websiteLinkController = TextEditingController();
  // var _socialMediaUsernameController = TextEditingController();
  // var _consultationFeeController = TextEditingController();
  // TimingModel _timingModel;
  // //dropdown data
  // var _businessPracticeList = ['Physical', 'Virtual', 'Both'];
  // String _selectedPractice;
  // var _paymentTypeList = ['Cash', 'Online', 'Both'];
  // String _selectedPaymentType;
  // //checkbox
  // bool isBuisnessWebsite = false;
  // bool isSocialMedia = false;
  // bool isDelivery = false;
  // bool sickNote = false, invoice = false, quotation = false;
  @override
  onClick(ClickType clickType) {
    if (_formKey.currentState.validate()) {
      String practiceYears = _yearsInPracticeController.text.trim();
      String website_link = _websiteLinkController.text.trim();
      String social_media_link =
      _socialMediaUsernameControllerInstagram.text.trim();
      String social_media_link2 =
      _socialMediaUsernameControllerLinkedIn.text.trim();
      String social_media_link3 =
      _socialMediaUsernameControllerFacebook.text.trim();
      String social_media_link4 =
      _socialMediaUsernameControllerWhatsapp.text.trim();

      String delivery_price = _deliveryPriceController.text.trim();
      String consultation_fee = _consultationFeeController.text.trim();
      if (_selectedPractice == null) {
        AppToast.showToast(message: 'Please choose Business Practice Type');
      } else if (_selectedPaymentType == null) {
        AppToast.showToast(message: 'Please choose payment type');
      } else if (_timingModel == null) {
        AppToast.showToast(message: 'Please select business operating hours');
      } else {
        widget._userData.addAll({
          AppKeys.CONSULTATION_FEE_PER_SESSION: consultation_fee,
          AppKeys.BUSINESS_PRACTICE_TYPE: _selectedPractice,
          AppKeys.PRACTICE_YEARS: practiceYears,
          AppKeys.COMPANY_WEBSITE: isBuisnessWebsite,
          AppKeys.COMPANY_WEBSITE_LINK: isBuisnessWebsite ? website_link : null,
          AppKeys.SOCIAL_MEDIA: isSocialMediaInsta,
          AppKeys.LIST_OF_SOCIAL_MEDIA:
          isSocialMediaInsta ? social_media_link : null,
          AppKeys.isSocialMediaLinkedIn: isSocialMediaLinkedIn,
          AppKeys.LinkedInList:
          isSocialMediaLinkedIn ? social_media_link2 : null,
          AppKeys.isSocialMediaFb: isSocialMediaFb,
          AppKeys.FbList: isSocialMediaFb ? social_media_link3 : null,
          AppKeys.isSocialMediaWhatsapp: isSocialMediaWhatsapp,
          AppKeys.WhatsappList:
          isSocialMediaWhatsapp ? social_media_link4 : null,
          AppKeys.IS_DELIVER: isDelivery,
          AppKeys.DELIVERY_PRICE: isDelivery ? delivery_price : null,
          AppKeys.TIMINGS: {
            AppKeys.SUNDAY_OPEN: _timingModel.sundayStart,
            AppKeys.SUNDAY_CLOSE: _timingModel.sundayEnd,
            AppKeys.MONDAY_OPEN: _timingModel.mondayStart,
            AppKeys.MONDAY_CLOSE: _timingModel.mondayEnd,
            AppKeys.TUESDAY_OPEN: _timingModel.tuesdayStart,
            AppKeys.TUESDAY_CLOSE: _timingModel.tuesdayEnd,
            AppKeys.WEDNESDAY_OPEN: _timingModel.wednesdayStart,
            AppKeys.WEDNESDAY_CLOSE: _timingModel.wednesdayEnd,
            AppKeys.THURSDAY_OPEN: _timingModel.thursdayStart,
            AppKeys.THURSDAY_CLOSE: _timingModel.thursdayEnd,
            AppKeys.FRIDAY_OPEN: _timingModel.fridayStart,
            AppKeys.FRIDAY_CLOSE: _timingModel.fridayEnd,
            AppKeys.SATURDAY_OPEN: _timingModel.saturdayStart,
            AppKeys.SATURDAY_CLOSE: _timingModel.saturdayEnd,
          },
        });

        NavigationController.push(
          context,
          ServiceProviderPersonalDetailScreen(
            widget._userData,
          ),
        );
      }
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