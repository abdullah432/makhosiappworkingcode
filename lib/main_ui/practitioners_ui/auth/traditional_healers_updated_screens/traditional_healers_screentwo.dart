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
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';

import 'traditional_healers_third_screen.dart';

// ignore: must_be_immutable
class TraditionalHealersScreenTwo extends StatefulWidget {
  Map<String, Object> _userData;

  TraditionalHealersScreenTwo(this._userData);

  @override
  _TraditionalHealersScreenTwoState createState() =>
      _TraditionalHealersScreenTwoState();
}

class _TraditionalHealersScreenTwoState
    extends State<TraditionalHealersScreenTwo>
    implements IRoundedButtonClicked {
  var _comercialProductsController = TextEditingController();
  var _ukuthawasaStartDateController = TextEditingController();
  var _typeOfInitiationController = TextEditingController();
  var _startAndEndOfTrainingController = TextEditingController();
  var _teacherNameController = TextEditingController();
  var _uGhobelaLocationController = TextEditingController();
  var _finalHomecomingCeremonyController = TextEditingController();
  var _threePeopleReferenceController = TextEditingController();
  //dropdown consultancy
  var _comercialProductsList = [
    'Herbal remedies',
    'Drums',
    'Traditional clothing',
    'Traditional Clothes'
  ];
  String _selectedComercialProduct;
  //form key
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
        padding: EdgeInsets.all(32),
        children: [
          _getBackButton(),
          Text(
            'Details Your Practice (Continued)',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          // AppTextFields.getTextField(
          //   controller: _comercialProductsController,
          //   label:
          //       'Do you have commercial products that you would like to sell?',
          //   isPassword: false,
          //   isNumber: false,
          // ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            child: DropdownButton(
              hint: Text(
                  'Do you have commercial products that you would like to sell?'),
              isExpanded: true,
              underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
              value: _selectedComercialProduct,
              items: _comercialProductsList
                  .map(
                    (item) => DropdownMenuItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item),
                      ),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _selectedComercialProduct = item;
                });
              },
            ),
          ),

          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _ukuthawasaStartDateController,
            label: 'When did you begin the process of ukuthwasa',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text(
            'Training/Initiation Details',
            style: TextStyle(fontSize: 19),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text(
            'Ukuthwasa nokukhula kwakho eDlozini',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.COLOR_GREY,
            ),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _teacherNameController,
            label: 'Name of your teacher',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _uGhobelaLocationController,
            label: 'Location of uGhobela/iNyanga',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _typeOfInitiationController,
            label: 'Type of initiation you have complemented',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _startAndEndOfTrainingController,
            label:
                'When did you start and conclude yorur official training/initiation',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          AppTextFields.getTextField(
            controller: _finalHomecomingCeremonyController,
            label: 'Where was your final  homecoming ceremony',
            isPassword: false,
            isNumber: false,
          ),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppTextFields.getMultiLineRegisterField(
            controller: _threePeopleReferenceController,
            label: '3 references: Please provider(name, surname, & email)',
          ),
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppButtons.getRoundedButton2(
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
            labelText: '',
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
    if (_selectedComercialProduct != null) {
      if (_formKey.currentState.validate()) {
        // String commercialProduct = _comercialProductsController.text.trim();
        String ukuthawasaStartDate = _ukuthawasaStartDateController.text.trim();
        String start_end_training_control =
            _startAndEndOfTrainingController.text.trim();
        String teacher = _teacherNameController.text.trim();
        String uGhobelLocation = _uGhobelaLocationController.text.trim();
        String homecommingCermonyLocation =
            _finalHomecomingCeremonyController.text.trim();
        String reference = _threePeopleReferenceController.text.trim();
        widget._userData.addAll({
          AppKeys.COMERICAL_PRODUCTS: _selectedComercialProduct,
          AppKeys.UKUTHWASA_PRACTICING_YEARS: ukuthawasaStartDate,
          AppKeys.UGHOBELA_LOCATION: uGhobelLocation,
          AppKeys.TEACHER: teacher,
          AppKeys.HOMECOMING_CEREMONY_LOCATION: homecommingCermonyLocation,
          AppKeys.REFERENCES: reference,
          AppKeys.TRAINING_END_DATE: start_end_training_control,
        });
        NavigationController.push(
          context,
          TraditionalHealersScreenThree(widget._userData),
        );
      }
    } else {
      AppToast.showToast(message: 'Please select dropdown menu');
    }
  }
}
