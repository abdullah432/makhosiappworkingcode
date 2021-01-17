import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_clickable_clicked.dart';
import 'package:makhosi_app/enums/field_type.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class AppClickableFields {
  static Widget getBorderedClickableField(String label, FieldType fieldType,
      IClickableClicked iClickableClicked, IconData icon) {
    return GestureDetector(
      onTap: () {
        iClickableClicked.onFieldClicked(fieldType);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.left,
              ),
            ),
            Icon(
              icon,
              color: AppColors.COLOR_PRIMARY,
            ),
          ],
        ),
      ),
    );
  }
}
