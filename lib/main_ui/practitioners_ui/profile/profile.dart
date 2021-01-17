import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/main_ui/administration/admin.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/practitioner_bookings_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/consultations.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/Screens/notification_screen.dart';
import 'package:makhosi_app/main_ui/general_ui/setting_page.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/facebook.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/youtube.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/twitter.dart';
import 'package:makhosi_app/Screens/account_screen.dart';
import 'package:makhosi_app/ui_components/settings/report_problem.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makhosi_app/utils/firestore_service.dart';

class profile2 extends StatefulWidget {
  dynamic snapshot;

  profile2(this.snapshot);
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile2> {
  bool reportPopupVisibility = false;
  TextEditingController reportTxtController = TextEditingController();
  final _formKeyreportfalult = GlobalKey<FormState>();
  bool isWaiting = false;
  FirestoreService database = FirestoreService();

  dynamic snapshot;
  bool _isViewer;
  String firstName = " ";
  String secondName = " ";
  String location = " ";
  String years = " ";
  String language = " ";
  String service = " ";
  dynamic instagram = " ";
  dynamic linkedin = " ";
  dynamic fb = " ";
  dynamic whatsapp = " ";
  void initState() {
    snapshot = widget.snapshot;
    super.initState();
    getdata();
  }

  void getdata() {
    firstName = snapshot['prefered_buisness_name'];
    secondName = snapshot[AppKeys.SECOND_NAME];
    location = snapshot[AppKeys.ADDRESS];
    years = snapshot[AppKeys.PRACTICE_YEARS];
    language = snapshot[AppKeys.LANGUAGES];
    service = snapshot[AppKeys.SERVICE_TYPE];
    instagram = snapshot['social_medias_list'];
    linkedin = snapshot['LinkedInList'];
    fb = snapshot['FbList'];
    whatsapp = snapshot['WhatsappList'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.COLOR_PRIMARY,
          leading: GestureDetector(
            onTap: () {
              NavigationController.push(
                context,
                PractitionersProfileScreen(_isViewer, snapshot),
              );
            },
            child: Image.asset('images/back_ar.png'),
          ),
        ),
        body: Stack(children: [
          Container(
              padding: EdgeInsets.all(13),
              child: ListView(children: [
                Card(
                  child: ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "images/circleavater.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Color(
                              0xff6043f5,
                            ),
                            width: 1,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text('${firstName} ${secondName}'),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new NotificationScreen()));
                        },
                        child: Image.asset(
                          'images/notification.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text('4.8 (53)')
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Accounts",
                      style: TextStyle(
                        color: Color(
                          0xff4a566c,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Open Sans",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('passbook')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection('transactions')
                        .orderBy('sentOn', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var listAmount = snapshot.data.docs.map<int>((snap) {
                          var data = snap.data();
                          return int.parse(data['amount']);
                        }).toList();
                        var totalAmount = listAmount.reduce((a, b) => a + b);
                        return Card(
                          child: ListTile(
                            leading: Image.asset('images/ic_payments.png'),
                            title: Text('My total earnings'),
                            trailing:
                                Text('${totalAmount.toStringAsFixed(2)}ZAR'),
                            onTap: () {
                              NavigationController.push(
                                context,
                                AccountsScreen(),
                              );
                            },
                          ),
                        );
                      }
                      return Card(
                        child: ListTile(
                          leading: Image.asset('images/ic_payments.png'),
                          title: Text('My total earnings'),
                          trailing: Text('\$2,800'),
                          onTap: () {
                            NavigationController.push(
                              context,
                              AccountsScreen(),
                            );
                          },
                        ),
                      );
                    }),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/ic_reports.png'),
                    title: Text('Reports'),
                    onTap: () {
                      reportPopupVisibility = true;
                    },
                    //trailing: Text('\$2,800')
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Business Space",
                      style: TextStyle(
                        color: Color(
                          0xff4a566c,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Open Sans",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/ic_bookmark_dark.png'),
                    title: Text('My Business Adminstration Portal'),
                    onTap: () {
                      NavigationController.push(
                        context,
                        Admin(),
                      );
                    },
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationController.push(
                        context,
                        Scaffold(
                          body: PractitionerBookingsScreen(),
                        ),
                      );
                    },
                    leading: Image.asset('images/ic_bookmark_dark copy.png'),
                    title: Text('My Appointments'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationController.push(
                        context,
                        Consultations(),
                      );
                    },
                    leading: Image.asset('images/ic_bookmark_dark copy 2.png'),
                    title: Text('My Inbox'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/ic_records.png'),
                    title: Text('My Business'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      print(firstName + location + years + language + service);
                      NavigationController.push(
                          context,
                          // BusinessCard2(
                          //     widget.snapshot['id'],
                          //     firstName,
                          //     location,
                          //     years,
                          //     language,
                          //     service,
                          //     instagram,
                          //     linkedin,
                          //     fb,
                          //     whatsapp)
                        BusinessCard()
                      );
                    },
                    leading: Image.asset('images/ic_ads.png'),
                    title: Text('My Business Card'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new NotificationScreen()));
                    },
                    leading: Image.asset('images/ic_notification_pressed.png'),
                    title: Text('Notifications'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/ic_patients_normal.png'),
                    title: Text('Referrals'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/Star.png'),
                    title: Text('User Feedback'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/ic_referral_code.png'),
                    title: Text('Referral code'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationController.push(
                        context,
                        SettingPage(),
                      );
                    },
                    leading: Image.asset('images/ic_settings.png'),
                    title: Text('Settings'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Find us on",
                      style: TextStyle(
                        color: Color(
                          0xff4a566c,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Open Sans",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationController.push(
                        context,
                        Facebook(),
                      );
                    },
                    leading: Image.asset('images/Shape-1.png'),
                    title: Text('Facebook'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationController.push(
                        context,
                        Twitter(),
                      );
                    },
                    leading: Image.asset('images/Shape.png'),
                    title: Text('Twitter'),
                    //trailing: Text('\$2,800')
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('images/002-youtube.png'),
                    title: Text('Youtube'),
                    onTap: () {
                      NavigationController.push(
                        context,
                        Youtube(),
                      );
                    },
                    //trailing: Text('\$2,800')
                  ),
                ),
              ])),
          Positioned(
            child: Visibility(
                visible: reportPopupVisibility,
                child: Form(
                  key: _formKeyreportfalult,
                  child: ReportProblemPopup(
                    controller: reportTxtController,
                    isWaiting: isWaiting,
                    onOutSideClick: () {
                      setState(() {
                        reportPopupVisibility = false;
                      });
                    },
                    onSend: () async {
                      if (_formKeyreportfalult.currentState.validate()) {
                        setState(() {
                          isWaiting = true;
                        });
                        await database.reportIssue(reportTxtController.text);

                        setState(() {
                          isWaiting = false;
                          reportPopupVisibility = false;
                          AppToast.showToast(message: 'Thanks for reporting');
                          reportTxtController.clear();
                        });
                      }
                    },
                  ),
                )),
          ),
        ]));
  }
}
