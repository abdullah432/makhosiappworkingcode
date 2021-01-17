import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:makhosi_app/tabs/near2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/contracts/i_dialogue_button_clicked.dart';
import 'package:makhosi_app/contracts/i_outlined_button_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/general_ui/login_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/auth/patient_register_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_dialogues.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:makhosi_app/thirdMain.dart';
import 'package:makhosi_app/main_ui/general_ui/settingpage2.dart';
import 'package:makhosi_app/Screens/notification_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patient_inbox_screen.dart';
import 'package:makhosi_app/main_ui/patients_ui/auth/update.dart';
class PatientProfileScreen extends StatefulWidget {
  DocumentSnapshot _snapshot;
  bool _isViewer;

  PatientProfileScreen(this._snapshot, this._isViewer);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen>
    implements
        IRoundedButtonClicked,
        IOutlinedButtonClicked,
        IDialogueButtonClicked {
  bool _isLoading = false;
  String _uid;
  var seen=0;
  void finished() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     seen=prefs.getInt('count');
  }
  @override
  Widget build(BuildContext context) {
    finished();
    return Scaffold(

      body: Stack(
        children: [


          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/Gradient.png',
              width: ScreenDimensions.getScreenWidth(context),
              height: ScreenDimensions.getScreenWidth(context) / 1.39,
              fit: BoxFit.cover,
            ),
          ),


          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 0,
                  height: ScreenDimensions.getScreenWidth(context) / 2.25,
                ),
                _getContentSection(),
              ],
            ),
          ),
          Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(left: 314,top: 600),

              child: GestureDetector(
                onTap: (){
                  showAlertDialog(context);
                },
                child: Image.asset('images/logout.png'),
              )
          ),
          Align(
            alignment: Alignment(-0.86, -0.88),
            child:  GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Image.asset(
                  'images/back_ar.png'
              ),

            ),
          ),
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("LOG OUT"),
      onPressed:  () async{
        Navigator.pop(context);
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({
          'online': false,
        }, SetOptions(merge: true));
        await Others.signOut();
        NavigationController.pushReplacement(
          context,
          LoginScreen(ClickType.PRACTITIONER),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out?"),
      content: Text("Are youn sure you want to log out of the app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget _getContentSection() {
    return Container(
      width: ScreenDimensions.getScreenWidth(context),
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: ScreenDimensions.getScreenWidth(context),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 26,
                        ),
                        Text(
                          widget._snapshot.get(AppKeys.FULL_NAME),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget._snapshot.get(AppKeys.ADDRESS),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'SERVICES\n LIKED',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              height: 45,
                              width: 2,
                              color: Colors.black38,
                            ),
                            Column(
                              children: [
                                Text(
                                  '2.5',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'CUSTOMER\n RATING',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              height: 45,
                              width: 2,
                              color: Colors.black38,
                            ),
                            Column(
                              children: [
                                seen!=null?
                                Text(
                                  '$seen',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ):Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'POINTS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        !widget._isViewer
                            ? FlatButton(
                          height: 40,
                          minWidth:170,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          color: AppColors.COLOR_PRIMARY,
                          onPressed: () {
                            NavigationController.pushReplacement(
                              context,
                              PatientRegisterScreen2(),
                            );
                            //NavigationController.push(
                            //context,
                            //BLogHomeScreen(_snapshot.id, true),
                            //);
                          },
                          child: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              !widget._isViewer ? Column(
    children: [
    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 5),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
      onPressed:(){
        NavigationController.push(
          context,
          app(),
        );
      },
    child: Row(
    children: [
    Text('MKHOSI KNOWLEDGE HUB', style: TextStyle(
    color: AppColors.COLOR_PRIMARY
    )
    ),
    SizedBox(
    width: 20,
    ),
      Image.asset(
        'images/arrow.png',
      )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),


    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 8),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
    onPressed: (){
      NavigationController.push(
        context,
        NearbyPractitionersTab2(),
      );
    },
    child: Row(
    children: [
    Text('FIND A SERVICE', style: TextStyle(
    color: AppColors.COLOR_PRIMARY,

    )
    ),

    SizedBox(
    width: 82,
    ),
      Image.asset(
        'images/arrow.png',
      )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid,
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),

    Container(
    margin: EdgeInsets.only(left: 35, right: 35, top: 8),
    child: FlatButton(
    height: 45,
    //minWidth: 50,
    onPressed: (){
      NavigationController.push(
        context,
        PractitionerInboxScreen(),
      );
    },
    child: Row(
    children: [
    Text('MESSAGES', style: TextStyle(
    color: AppColors.COLOR_PRIMARY,

    )
    ),

    SizedBox(
    width: 101,
    ),
      Image.asset(
        'images/arrow.png',
      )

    ],
    ),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(side: BorderSide(
    color: AppColors.COLOR_PRIMARY,
    width: 1,
    style: BorderStyle.solid,
    ), borderRadius: BorderRadius.circular(50)),
    ),
    ),
    ],
    ) : Container(),
            ],
          ),
          !widget._isViewer
              ? Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(right: 15, top: 50),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Image.asset(
                          'images/setting.png'
                      ),
                      onTap: () {
                        NavigationController.push(
                          context,
                          SettingPage( widget._snapshot.get(AppKeys.FULL_NAME)));
                      },
                    ),
                  ),

                ],
              ),
            ),
          )
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.only(left: 15, top: 50),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: Image.asset(
                     'images/notification.png'
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>new NotificationScreen()));

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _getImageSection(),

        ],
      ),
    );
  }

  Widget _getImageSection() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.only(bottom: 600) ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: !widget._isViewer ? () {
                _openGallery();
              } : null,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: NetworkImage(
                  widget._snapshot.get(AppKeys.PROFILE_IMAGE) == null
                      ? 'https://image.freepik.com/free-vector/follow-me-social-business-theme-design_24877-52233.jpg'
                      : widget._snapshot.get(AppKeys.PROFILE_IMAGE),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  _openGallery();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
            ),
            _isLoading
                ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _openGallery() async {
    var pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });
      Others.clearImageCache();
      _uploadImage(pickedFile);
    }
  }

  void _uploadImage(PickedFile pickedFile) {
    _uid = FirebaseAuth.instance.currentUser.uid;
    StorageReference ref = FirebaseStorage.instance.ref().child(
          'profile_images/$_uid.jpg',
        );
    StorageUploadTask task = ref.putFile(File(pickedFile.path));
    task.onComplete.then((_) async {
      String downloadUrl = await _.ref.getDownloadURL();
      _updateProfileData(downloadUrl);
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        AppToast.showToast(message: error.toString());
      });
    });
  }

  Future<void> _updateProfileData(String downloadUrl) async {
    try {
      await FirebaseFirestore.instance.collection('patients').doc(_uid).set(
        {
          AppKeys.PROFILE_IMAGE: downloadUrl,
        },
        SetOptions(merge: true),
      );
      widget._snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(_uid)
          .get();
      setState(() {
        _isLoading = false;
      });
    } catch (exc) {
      setState(() {
        _isLoading = false;
        AppToast.showToast(message: exc.toString());
      });
    }
  }

  @override
  onClick(ClickType clickType) {
    NavigationController.pushReplacement(
      context,
      PatientRegisterScreen(ClickType.PATIENT, widget._snapshot),
    );
  }

  @override
  void onOutlineButtonClicked(ClickType clickType) {
    // ignore: missing_enum_constant_in_switch
    switch (clickType) {
      case ClickType.LOGOUT:
        AppDialogues.showConfirmationDialogue(
          context: context,
          title: 'Sign Out!',
          label: 'Are you sure you want to sign out?',
          negativeButtonLabel: 'Cancel',
          positiveButtonLabel: 'Sign Out',
          iDialogueButtonClicked: this,
        );
        break;
    }
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
    Navigator.pop(context);
    await Others.signOut();
    NavigationController.pushReplacement(
      context,
      LoginScreen(ClickType.PRACTITIONER),
    );
  }
}
