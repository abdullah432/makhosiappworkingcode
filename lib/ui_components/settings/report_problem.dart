import 'package:flutter/material.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';

import '../app_text_fields.dart';

class ReportProblemPopup extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onOutSideClick;
  final VoidCallback onSend;
  final bool isWaiting;
  const ReportProblemPopup({
    @required this.controller,
    @required this.onOutSideClick,
    @required this.onSend,
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
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Container(
                  width: 0,
                  height: 0,
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
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12.0,
                  left: 25.0,
                  right: 25.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Report a problem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppTextFields.getMultiLineRegisterField(
                      label:
                          'This report will help us to improve our application',
                      controller: controller,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    AppButtons.getButton(
                      label: 'Send',
                      context: context,
                      onTap: onSend,
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
