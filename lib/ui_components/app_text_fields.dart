import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_text_changed_listener.dart';
import 'package:makhosi_app/contracts/i_trailing_clicked.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class AppTextFields {
  static Widget getLoginField({
    @required TextEditingController controller,
    @required String label,
    @required bool isPassword,
    @required bool isNumber,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) return "This field can't be empty";
        return null;
      },
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: isPassword,
      style: TextStyle(
        color: Colors.grey,

      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.GREYISH_RED,
          contentPadding: EdgeInsets.all(12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey,
          )),
    );
  }

  static Widget getMultiLineRegisterField({
    @required TextEditingController controller,
    @required String label,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.length < 10) return "Please enter miniumum 10 characters";
        return null;
      },
      style: TextStyle(
        color: Colors.grey,
      ),
      maxLines: 5,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintMaxLines: 3,
      ),

    );
  }

  static Widget getTextField({
    @required TextEditingController controller,
    @required String label,
    @required bool isPassword,
    @required bool isNumber,
  }) {
    return TextFormField(

      controller: controller,
      validator: (value) {
        if (value.isEmpty) return "This field can't be empty";
        return null;
      },
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: isPassword,
      style: TextStyle(
        color: Colors.grey,

      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        hintText: label,
        hintMaxLines: 2,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12
        ),

      ),
    );
  }

  static Widget getSearchTextField({
    @required controller,
    @required hint,
    @required textListener,
    @required ITrailingClicked iTrailingClicked,
  }) {
    return TextField(
      onChanged: (val) {
        if (textListener != null)
          (textListener as ITextChangedListener).onTextChanged(val);
      },
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: iTrailingClicked != null
            ? IconButton(
                icon: Icon(Icons.filter_alt),
                onPressed: () {
                  iTrailingClicked.onTrailingClick();
                },
              )
            : Icon(Icons.ac_unit, color: Colors.transparent),
        prefixIcon: Icon(
          Icons.search,
        ),
        contentPadding: EdgeInsets.all(12),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
