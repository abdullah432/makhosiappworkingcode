import 'package:flutter/material.dart';

class DateTimeHelper {
  Future<String> openDatePicker(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 36500),
      ),
      lastDate: DateTime.now(),
    );
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
