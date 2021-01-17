import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_clickable_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/enums/field_type.dart';
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

// ignore: must_be_immutable
class PractitionerRegisterScreenSecond extends StatefulWidget {
  Map<String, Object> _userData;

  PractitionerRegisterScreenSecond(this._userData);

  @override
  _PractitionerRegisterScreenSecondState createState() =>
      _PractitionerRegisterScreenSecondState();
}

class _PractitionerRegisterScreenSecondState
    extends State<PractitionerRegisterScreenSecond>
    implements IRoundedButtonClicked, IClickableClicked {
  var _diagnosisController = TextEditingController();
  var _treatmentController = TextEditingController();
  var _specialitiesController = TextEditingController();
  var _teacherController = TextEditingController();
  var _herbalProductsController = TextEditingController();
  var _rulesController = TextEditingController();
  var _sessionTimeController = TextEditingController();
  var _ritualsController = TextEditingController();
  TimingModel _timingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getForm(),
    );
  }

  Widget _getForm() {
    return ListView(
      padding: EdgeInsets.all(32),
      children: [
        _getBackButton(),
        Text(
          'Details about Practice',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        AppTextFields.getTextField(
          controller: _diagnosisController,
          label: 'What do you diagnose?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _treatmentController,
          label: 'What treatments do you dispense?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _specialitiesController,
          label: 'Particular Specialities?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _teacherController,
          label: 'Are you a teacher?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _sessionTimeController,
          label: 'How long does your session last?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _ritualsController,
          label: 'Available for ceremonies/rituals?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppClickableFields.getBorderedClickableField(
          _timingModel == null
              ? 'Timing'
              : 'Selected ${_timingModel.mondayStart}.....',
          FieldType.TIME,
          this,
          Icons.watch,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getMultiLineRegisterField(
          controller: _herbalProductsController,
          label: 'Herbal products if you are herbalist',
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getMultiLineRegisterField(
          controller: _rulesController,
          label: 'List your rules',
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
              Navigator.pop(context);
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
    String diagnoses = _diagnosisController.text.trim();
    String treatment = _treatmentController.text.trim();
    String particularSpecialities = _specialitiesController.text.trim();
    String teacher = _teacherController.text.trim();
    String sessionDuration = _sessionTimeController.text.trim();
    String ritualAvailability = _ritualsController.text.trim();
    String herbalProducts = _herbalProductsController.text.trim();
    String rules = _rulesController.text.trim();
    if (diagnoses.isEmpty) {
      AppToast.showToast(message: 'Diagnoses cannot be empty');
    } else if (treatment.isEmpty) {
      AppToast.showToast(message: 'Treatment cannot be empty');
    } else if (particularSpecialities.isEmpty) {
      AppToast.showToast(message: 'Particular specialities cannot be empty');
    } else if (teacher.isEmpty) {
      AppToast.showToast(message: 'Mention if you are a teacher or not');
    } else if (sessionDuration.isEmpty) {
      AppToast.showToast(message: 'Mention session duration first');
    } else if (ritualAvailability.isEmpty) {
      AppToast.showToast(
          message: 'Mention if you are available for rituals or ceremonies');
    } else if (_timingModel == null) {
      AppToast.showToast(message: 'Please add timings first');
    } else if (rules.isEmpty) {
      AppToast.showToast(message: 'Mention your rules first');
    } else {
      widget._userData.addAll({
        AppKeys.DIAGNOSIS: diagnoses,
        AppKeys.TREATMENT: treatment,
        AppKeys.SPECIALITIES: particularSpecialities,
        AppKeys.TEACHER: teacher,
        AppKeys.SESSION_DURATION: sessionDuration,
        AppKeys.RITUAL_AVAILABILITY: ritualAvailability,
        AppKeys.HERBAL_PRODUCTS: herbalProducts,
        AppKeys.RULES_FOR_PATIENT: rules,
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
        PractitionerRegisterScreenThird(
          widget._userData,
        ),
      );
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
