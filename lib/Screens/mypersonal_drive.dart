import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';
import 'package:makhosi_app/Assets/custom_listtile.dart';
import 'package:makhosi_app/ui_components/settings/report_problem.dart';
import 'package:makhosi_app/utils/app_dialogues.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/firestore_service.dart';
import 'package:makhosi_app/utils/methods.dart';

class MyPersonalStorage extends StatefulWidget {
  final totalUseStorageSize;
  const MyPersonalStorage({@required this.totalUseStorageSize});
  @override
  _MyPersonalStorageState createState() => _MyPersonalStorageState();
}

class _MyPersonalStorageState extends State<MyPersonalStorage> {
  //default total size is 10GB
  int totalStorage = 10;
  //form Key

  final _formKeyreportfalult = GlobalKey<FormState>();

  //firebase service
  FirestoreService database = FirestoreService();

  //reportproblem
  bool reportPopupVisibility = false;
  TextEditingController reportTxtController = TextEditingController();
  //waiting circularindicator
  bool isWaiting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themecolor,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  "My Personal Drive",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('images/storage_icon.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Free Storage",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              Methods.totalFreeSpace(
                                  widget.totalUseStorageSize, totalStorage),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          Text(
                            "From Total 10 Gb",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 80),
                child: Column(
                  children: [
                    // notification_alert(
                    //   title: "Notifications",
                    // ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          reportPopupVisibility = true;
                        });
                      },
                      child: HelpandFeeback(
                        title: "Help & feedback",
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    AppDialogues.showUpgradeStoragePopup(context);
                  },
                  child: Card(
                    elevation: 5,
                    color: AppColors.accentcolor,
                    shadowColor: AppColors.accentcolor,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Upgrade Storage',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      returnBtn(
                        title: "Return to Profile",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
