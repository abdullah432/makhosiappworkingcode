import 'package:flutter/material.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class NotificationPopup extends StatelessWidget {
  final bool switchControl;
  final VoidCallback onOutSideClick;
  final VoidCallback onSubmit;
  final Function(bool value) onChanged;
  const NotificationPopup({
    @required this.switchControl,
    @required this.onOutSideClick,
    @required this.onSubmit,
    @required this.onChanged,
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
        )
      ],
    );
  }

  popupBoxWidget(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          // width: MediaQuery.of(context).size.width / 1.25,
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
                      'Enable/Disable Notification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Notifications'),
                        Switch(
                          value: switchControl,
                          activeColor: AppColors.COLOR_PRIMARY,
                          onChanged: onChanged,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppButtons.getButton(
                      label: 'Confirm',
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
