import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_string_drop_down_item_selected.dart';
import 'package:makhosi_app/utils/others.dart';

class AppDropDowns {
  static Widget getBorderedStringDropDown(
    IStringDropDownItemSelected iStringDropDownItemSelected,
    String selectedItem,
    List<String> itemsList,
  ) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: Others.getSizedBox(boxHeight: 0, boxWidth: 0),
        value: selectedItem,
        items: itemsList
            .map(
              (item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ),
            )
            .toList(),
        onChanged: (item) {
          iStringDropDownItemSelected.onItemStringDropDownItemSelected(item);
        },
      ),
    );
  }
}
