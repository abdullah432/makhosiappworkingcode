import 'package:flutter/material.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class ReportPopup extends StatelessWidget {
  final TextEditingController namecontroller;
  final TextEditingController complaincontroller;
  final String reportTitle;
  final String reportInstruction;
  final String nameFieldLabel;
  final String complainFieldLabel;
  final VoidCallback onOutSideClick;
  final VoidCallback onSubmit;
  final bool isWaiting;
  const ReportPopup({
    @required this.namecontroller,
    @required this.complaincontroller,
    @required this.reportTitle,
    @required this.reportInstruction,
    @required this.nameFieldLabel,
    @required this.complainFieldLabel,
    @required this.onOutSideClick,
    @required this.onSubmit,
    @required this.isWaiting,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onOutSideClick,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.LIGHT_GREY.withOpacity(0.4),
          ),
        ),
        Positioned(
          child: popupBoxWidget(context),
        ),
        Positioned.fill(
          bottom: 10.0,
          child: isWaiting
              ? CircularProgressIndicator()
              : Container(
                  height: 0,
                  width: 0,
                ),
        ),
      ],
    );
  }

  popupBoxWidget(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      reportTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(reportInstruction)),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppTextFields.getTextField(
                      label: nameFieldLabel,
                      isNumber: false,
                      isPassword: false,
                      controller: namecontroller,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AppTextFields.getMultiLineRegisterField(
                      controller: complaincontroller,
                      label: complainFieldLabel,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    AppButtons.getButton(
                      label: 'Submit',
                      context: context,
                      onTap: onSubmit,
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
    );
  }
}
