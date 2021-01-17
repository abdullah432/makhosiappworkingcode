import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:hexcolor/hexcolor.dart';

class AppButtons {
  static Widget getRoundedButton({
    @required BuildContext context,
    @required IRoundedButtonClicked iRoundedButtonClicked,
    @required String label,
    @required ClickType clickType,
  }) {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      height: 45,
      child: RaisedButton(
        color: AppColors.COLOR_PRIMARY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          iRoundedButtonClicked.onClick(clickType);
        },
      ),
    );
  }
  static Widget getRoundedButton2({
    @required BuildContext context,
    @required IRoundedButtonClicked iRoundedButtonClicked,
    @required String label,
    @required ClickType clickType,
  }) {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      height: 45,
      child: RaisedButton(
        color: Hexcolor("#252C4A"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          iRoundedButtonClicked.onClick(clickType);
        },
      ),
    );
  }
  static Widget getOutlineButton({
    @required BuildContext context,
    @required IOutlinedButtonClicked iOutlinedButtonClicked,
    @required String label,
    @required ClickType clickType,
    IconData icon,
  }) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: AppColors.COLOR_PRIMARY,
        ),
      ),
      onPressed: () {
        iOutlinedButtonClicked.onOutlineButtonClicked(clickType);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon == null ? Icons.gradient : icon,
            color: AppColors.COLOR_PRIMARY,
          ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.COLOR_PRIMARY,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget getButton({
    @required BuildContext context,
    @required VoidCallback onTap,
    @required String label,
  }) {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      height: 45,
      child: RaisedButton(
        color: AppColors.COLOR_PRIMARY,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
