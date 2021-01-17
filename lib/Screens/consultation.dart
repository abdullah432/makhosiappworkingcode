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
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/serviceproviders/serviceprovider_first_screen.dart';
import 'package:makhosi_app/utils/string_constants.dart';
class consultation extends StatefulWidget {
  @override
  _consultationState createState() => _consultationState();
}

class _consultationState extends State<consultation> implements IClickableClicked {
  var _consultationFeeController = TextEditingController();
  var _paymentTypeList = ['Cash', 'Online', 'Both'];
  String _selectedPaymentType;
  TimingModel _timingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultation Fee'
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset('images/back_img.png'),
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text('Consultation Fee/hour (ZAR)', style: TextStyle(
            color: AppColors.COLOR_PRIMARY,
          ),),
          AppTextFields.getTextField(
            controller: _consultationFeeController,
            label: 'Consultation Fee per session (ZAR)',
            isPassword: false,
            isNumber: true,
          ),
          Others.getSizedBox(boxHeight: 16, boxWidth: 0),
          Text('Cash or Online Payment', style: TextStyle(
            color: AppColors.COLOR_PRIMARY,
          ),),
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
          Text('Session Duration', style: TextStyle(
            color: AppColors.COLOR_PRIMARY,
          ),),
          AppClickableFields.getBorderedClickableField(
            _timingModel == null
                ? 'Business Operating Hours'
                : 'Selected ${_timingModel.mondayStart}.....',
            FieldType.TIME,
            this,
            Icons.watch,
          ),    Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppButtons.getRoundedButton(
            context: context,
           // iRoundedButtonClicked: this,
            label: 'SAVE',
            clickType: ClickType.DUMMY,
          ),

        ],
      ),
    );
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
