import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class PaidFee extends StatelessWidget {
  final String sender;
  final int amount;
  PaidFee({this.sender, this.amount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('patients')
              .doc(sender)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data.data();
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.COLOR_PRIMARY,
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 30,
                      ),
                      radius: 40,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'You have received funds!',
                      style: TextStyle(
                          color: AppColors.COLOR_PRIMARY, fontSize: 22),
                    ),
                    Text(
                      'From customer',
                      style:
                          TextStyle(color: AppColors.LIGHT_GREY, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: (user.containsKey('profile_image') &&
                              user['profile_image'] != null)
                          ? NetworkImage(
                              user['profile_image'],
                            )
                          : AssetImage('images/circleavater.png'),
                    ),
                    Text(
                      user['full_name'],
                      style: TextStyle(
                          color: AppColors.COLOR_PRIMARY, fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'R$amount',
                          style: TextStyle(
                              color: AppColors.COLOR_PRIMARY, fontSize: 30),
                        ),
                        Text(
                          'ZAR',
                          style: TextStyle(
                              color: AppColors.COLOR_PRIMARY, fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.COLOR_PRIMARY,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    ),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You have received funds!',
                    style:
                        TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 24),
                  ),
                  Text(
                    'From customer',
                    style: TextStyle(color: AppColors.LIGHT_GREY, fontSize: 16),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/circleavater.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                            color: AppColors.COLOR_PRIMARY, fontSize: 30),
                      ),
                      Text(
                        'ZAR',
                        style: TextStyle(
                            color: AppColors.COLOR_PRIMARY, fontSize: 24),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 30),
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
    );
  }
}
