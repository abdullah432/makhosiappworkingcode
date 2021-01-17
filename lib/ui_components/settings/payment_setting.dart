import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/firestore_service.dart';

import '../app_buttons.dart';
import '../app_text_fields.dart';

class PaymentSettingPage extends StatefulWidget {
  PaymentSettingPage({Key key}) : super(key: key);

  @override
  _PaymentSettingPageState createState() => _PaymentSettingPageState();
}

class _PaymentSettingPageState extends State<PaymentSettingPage> {
  //formkey
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bandNameController = TextEditingController();
  TextEditingController branchCodeController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController updateCostPerSessionController =
      TextEditingController();
  TextEditingController currencyController = TextEditingController();
  //switch boxes
  bool acceptCashPayment = true;
  bool acceptOnlinePayment = true;
  //iswaiting
  bool isWaiting = false;

  @override
  void dispose() {
    accountHolderController.dispose();
    accountNumberController.dispose();
    bandNameController.dispose();
    currencyController.dispose();
    branchCodeController.dispose();
    updateCostPerSessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.LIGHT_GREY.withOpacity(0.4),
            ),
          ),
          Positioned(
            child: popupBoxWidget(context),
          )
        ],
      ),
    );
  }

  popupBoxWidget(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 35,
          bottom: 35,
        ),
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Update Banking Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Account Number',
                        isNumber: true,
                        isPassword: false,
                        controller: accountNumberController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Bank Name',
                        isNumber: false,
                        isPassword: false,
                        controller: bandNameController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Branch Code',
                        isNumber: false,
                        isPassword: false,
                        controller: branchCodeController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Account Holder Name',
                        isNumber: false,
                        isPassword: false,
                        controller: accountHolderController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Accept Cash Payment'),
                          Switch(
                            value: acceptCashPayment,
                            activeColor: AppColors.COLOR_PRIMARY,
                            onChanged: (value) {
                              setState(() {
                                print('value: ' + value.toString());
                                acceptCashPayment = value;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Accept Online Payment'),
                          Switch(
                            value: acceptOnlinePayment,
                            activeColor: AppColors.COLOR_PRIMARY,
                            onChanged: (value) {
                              print('value: ' + value.toString());
                              setState(() {
                                acceptOnlinePayment = value;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Update Cost Per Session',
                        isNumber: false,
                        isPassword: false,
                        controller: updateCostPerSessionController,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppTextFields.getTextField(
                        label: 'Currency',
                        isNumber: false,
                        isPassword: false,
                        controller: currencyController,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      AppButtons.getButton(
                        label: 'Update Payment Detail',
                        context: context,
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isWaiting = true;
                            });
                            FirestoreService database = FirestoreService();
                            await database.updateBankingDetail(
                              accountNumber: accountNumberController.text,
                              bankName: bandNameController.text,
                              branchCode: branchCodeController.text,
                              accountHolder: accountHolderController.text,
                              updateCostPerSession:
                                  updateCostPerSessionController.text,
                              currency: currencyController.text,
                              acceptCash: acceptCashPayment,
                              acceptOnline: acceptOnlinePayment,
                            );

                            _formKey.currentState.reset();

                            setState(() {
                              isWaiting = false;
                            });
                            AppToast.showToast(
                                message:
                                    'Payment Information Updated Successfully');
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppButtons.getButton(
                        label: 'Back',
                        context: context,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
