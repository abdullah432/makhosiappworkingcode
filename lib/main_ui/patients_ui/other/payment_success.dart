import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/utils/app_colors.dart';

Future showPaymentSuccess(BuildContext context, Map transactionDetails) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: EdgeInsets.all(10),
      title: CircleAvatar(
        backgroundColor: AppColors.COLOR_PRIMARY,
        radius: 25,
        child: Center(
          child: Icon(
            Icons.done,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height / 1.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  'You sent money ',
                  style: TextStyle(color: AppColors.PAY_SUBTITLE, fontSize: 14),
                ),
                Text(
                  'successfully',
                  style:
                      TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 14),
                ),
              ],
            ),
            Text(
              'to',
              style: TextStyle(color: AppColors.PAY_SUBTITLE, fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0XFFF6F7FB),
                borderRadius: BorderRadius.circular(30),
              ),
              height: 60,
              width: 170,
              padding: EdgeInsets.all(2),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: transactionDetails != null
                        ? NetworkImage(
                            transactionDetails['receiverProPic'],
                          )
                        : AssetImage('images/circleavater.png'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transactionDetails['receiverName'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.PAY_SUBTITLE,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${transactionDetails['amount']} ZAR',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.COLOR_PRIMARY,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Transaction ID ',
                  style: TextStyle(color: AppColors.LIGHT_GREY, fontSize: 14),
                ),
                Text(
                  transactionDetails['transactionId'].substring(0, 8),
                  style:
                      TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'executed on',
                  style: TextStyle(color: AppColors.LIGHT_GREY, fontSize: 14),
                ),
                Text(
                  DateFormat('MMMM d, yyyy')
                      .format(transactionDetails['sentOn'].toDate()),
                  style:
                      TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: AppColors.COLOR_PRIMARY,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        'DONE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [],
    ),
  );
}
