import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class EarningDialogBox extends StatelessWidget {
  EarningDialogBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      // elevation: 0,
      // backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Text(
              'Earning (ZAR) ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '0 is your total amount of earnings from all your transactions on the app',
              style: TextStyle(
                fontFamily: 'Poppins',
                // fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
