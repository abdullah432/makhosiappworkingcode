import 'package:flutter/material.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';

import '../app_text_fields.dart';

class SendInvitationPopup extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onOutSideClick;
  final VoidCallback onSend;
  final bool isWaiting;
  const SendInvitationPopup({
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
              ? CircularProgressIndicator()
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
          // width: MediaQuery.of(context).size.width / 1.15,
          // height: MediaQuery.of(context).size.height / 2.4,
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
                      'Invite Friend',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppTextFields.getTextField(
                      label: 'Enter Email',
                      isNumber: false,
                      isPassword: false,
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
