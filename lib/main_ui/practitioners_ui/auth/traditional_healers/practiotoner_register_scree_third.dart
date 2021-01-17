import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_fourth.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers/practitioner_register_screen_second.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_labels.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

// ignore: must_be_immutable
class PractitionerRegisterScreenThird extends StatefulWidget {
  Map<String, Object> _userData;

  PractitionerRegisterScreenThird(this._userData);

  @override
  _PractitionerRegisterScreenThirdState createState() =>
      _PractitionerRegisterScreenThirdState();
}

class _PractitionerRegisterScreenThirdState
    extends State<PractitionerRegisterScreenThird>
    implements IRoundedButtonClicked {
  var _referenceController = TextEditingController();
  var _ukuthwasaController = TextEditingController();
  var _onlineConsultationController = TextEditingController();
  var _medicineSourceController = TextEditingController();
  var _criminalRecordController = TextEditingController();
  var _initiatesController = TextEditingController();

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
          controller: _onlineConsultationController,
          label: 'Do you consult online?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _medicineSourceController,
          label: 'Where do you source your medicine (imithi)',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _ukuthwasaController,
          label: 'Ukuthwasa practice years',
          isPassword: false,
          isNumber: true,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getMultiLineRegisterField(
          controller: _referenceController,
          label: 'References (add 3 people)',
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        Text(
          'Ethical Considerations',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        Others.getSizedBox(boxHeight: 8, boxWidth: 0),
        AppTextFields.getTextField(
          controller: _criminalRecordController,
          label: 'Do you have criminal record?',
          isPassword: false,
          isNumber: false,
        ),
        Others.getSizedBox(boxHeight: 16, boxWidth: 0),
        AppTextFields.getMultiLineRegisterField(
          controller: _initiatesController,
          label: 'Initiates that have abandoned their training?',
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
  onClick(ClickType clickType) {
    String onlineConsultation = _onlineConsultationController.text.trim();
    String medicineSource = _medicineSourceController.text.trim();
    String references = _referenceController.text.trim();
    String ukuthwasaPracticingYears = _ukuthwasaController.text.trim();
    String criminality = _criminalRecordController.text.trim();
    String initiates = _initiatesController.text.trim();
    if (onlineConsultation.isEmpty) {
      AppToast.showToast(message: 'Online consultation field cannot  be empty');
    } else if (medicineSource.isEmpty) {
      AppToast.showToast(message: 'Medicine sourcing cannot be empty');
    } else if (references.isEmpty) {
      AppToast.showToast(message: 'References cannot be empty');
    } else if (ukuthwasaPracticingYears.isEmpty) {
      AppToast.showToast(message: 'Ukuthwasa practicing years cannot be empty');
    } else if (criminality.isEmpty) {
      AppToast.showToast(message: 'ID number cannot be empty');
    } else if (initiates.isEmpty) {
      AppToast.showToast(message: 'Mention your past initiates first');
    } else {
      widget._userData.addAll({
        AppKeys.ONLINE_CONSULTATION: onlineConsultation,
        AppKeys.MEDICINE_SOURCING: medicineSource,
        AppKeys.REFERENCES: references,
        AppKeys.UKUTHWASA_PRACTICING_YEARS: ukuthwasaPracticingYears,
        AppKeys.CRIMINALITY: criminality,
        AppKeys.PAST_INITIATES: initiates,
      });
      NavigationController.push(
        context,
        PractiotnerRegisterScreenFourth(
          widget._userData,
        ),
      );
    }
  }
}
