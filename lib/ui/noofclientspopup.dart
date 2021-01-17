import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class NoOfClientsDialogBox extends StatelessWidget {
  NoOfClientsDialogBox({
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
              'No. of Clients ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'You have 0 number of Clients according to the number of bookings or your active orders. Clients will find you on the Mkhosi listing pages',
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
