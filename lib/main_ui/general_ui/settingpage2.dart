import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:makhosi_app/Screens/notification_screen.dart';
import 'package:makhosi_app/contracts/i_info_dialog_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/auth/update.dart';
import 'package:makhosi_app/ui_components/circularbutton.dart';
import 'package:makhosi_app/ui_components/settings/about_page.dart';
import 'package:makhosi_app/ui_components/settings/help_center.dart';
import 'package:makhosi_app/ui_components/settings/notification_popup.dart';
import 'package:makhosi_app/ui_components/settings/payment_setting.dart';
import 'package:makhosi_app/ui_components/settings/report_client.dart';
import 'package:makhosi_app/ui_components/settings/report_problem.dart';
import 'package:makhosi_app/ui_components/settings/send_invitation_popup.dart';
import 'package:makhosi_app/ui_components/settings/terms_policy.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/firestore_service.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/string_constants.dart';

import 'login_screen.dart';

class SettingPage extends StatefulWidget {
  String name;
  SettingPage(this.name);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    implements IInfoDialogClicked {
  //form Key
  final _formKeyReportUser = GlobalKey<FormState>();
  final _formKeySendInvitation = GlobalKey<FormState>();
  final _formKeyreportfalult = GlobalKey<FormState>();
  //bool isNavigateFromServiceProvider=false;
  //_SettingPageState(this.isNavigateFromServiceProvider);
  //firebase service
  FirestoreService database = FirestoreService();
  //list of setting icons
  List<SettingItem> listOfSettingItems;
  //texteditingcontroller
  TextEditingController namecontroller = TextEditingController();
  TextEditingController complaincontroller = TextEditingController();
  //visibiltiy
  bool clientReportVisibility = false;
  //notification switch controll
  bool notificationSwitchControl = false;
  bool notificationPopupVisibility = false;
  //language picker
  Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');
  //send invitaion
  bool invitationPopupVisibility = false;
  TextEditingController invitationFriendController = TextEditingController();
  //reportproblem
  bool reportPopupVisibility = false;
  TextEditingController reportTxtController = TextEditingController();
  //waiting circularindicator
  bool isWaiting = false;

  @override
  void initState() {
    listOfSettingItems = [
      SettingItem(title: 'Edit Profile', icon: Icons.notifications),
      SettingItem(title: 'Notifications Settings', icon: Icons.notifications),
      SettingItem(title: 'Language', icon: Icons.language),
      SettingItem(title: 'Report a Service Provider', icon: Icons.warning),
      SettingItem(title: 'Invite a friend', icon: Icons.person),
      // SettingItem(title: 'Payment Settings', icon: Icons.payment),
      SettingItem(title: 'Help Center', icon: Icons.help_center),
      SettingItem(title: 'Report a Problem', icon: Icons.report_problem),
      SettingItem(title: 'Term and Policies', icon: Icons.policy),
      SettingItem(title: 'About', icon: Icons.info),
      SettingItem(title: 'Logout', icon: Icons.logout),
    ];
    super.initState();
  }

  @override
  void dispose() {
    reportTxtController.dispose();
    namecontroller.dispose();
    invitationFriendController.dispose();
    complaincontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(onBackPressed());
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          title: Text(widget.name),
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
                              Text('No ratings')
                            ],
                          )),
                    ),
                    Column(
                      children: listOfSettingItems
                          .map((item) => InkWell(
                                onTap: () => onSettingItemClick(
                                  listOfSettingItems.indexOf(item),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      CircularButton(
                                        icon: item.icon,
                                        iconColor: Colors.white,
                                        color: AppColors.COLOR_PRIMARY,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(item.title),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.COLOR_GREY,
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            //report client/customer
            Positioned(
              child: Visibility(
                visible: clientReportVisibility,
                child: Form(
                  key: _formKeyReportUser,
                  child: ReportPopup(
                    namecontroller: namecontroller,
                    complaincontroller: complaincontroller,
                    isWaiting: isWaiting,
                    reportTitle: StringConstants.REPORT_SERVER_PROVIDER,
                    reportInstruction:
                        StringConstants.REPORT_SERVER_PROVIDER_INSTRUCTIONS,
                    nameFieldLabel: 'Name of Service Provider',
                    complainFieldLabel: 'State the reason for complaint',
                    onOutSideClick: () {
                      setState(() {
                        clientReportVisibility = false;
                      });
                    },
                    onSubmit: () async {
                      print('submit');
                      if (_formKeyReportUser.currentState.validate()) {
                        FirestoreService database = FirestoreService();
                        String userid = database.getCurrentUserID();
                        setState(() {
                          isWaiting = true;
                        });
                        await database.reportUser(
                          namecontroller.text,
                          complaincontroller.text,
                          userid,
                          'SERVICEPROVIDER',
                        );
                        setState(() {
                          AppToast.showToast(message: 'Reported Successfully');
                          isWaiting = false;
                          clientReportVisibility = false;
                          namecontroller.clear();
                          complaincontroller.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            //notification popup
            Positioned(
              child: Visibility(
                  visible: notificationPopupVisibility,
                  child: NotificationPopup(
                    switchControl: notificationSwitchControl,
                    onOutSideClick: () {
                      setState(() {
                        notificationPopupVisibility = false;
                      });
                    },
                    onSubmit: () {
                      //#TODO: submit to firestore
                      setState(() {
                        notificationPopupVisibility = false;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        notificationSwitchControl = value;
                      });
                    },
                  )),
            ),
            //send invitation popup
            Positioned(
              child: Visibility(
                  visible: invitationPopupVisibility,
                  child: Form(
                    key: _formKeySendInvitation,
                    child: SendInvitationPopup(
                      controller: invitationFriendController,
                      isWaiting: isWaiting,
                      onOutSideClick: () {
                        setState(() {
                          invitationPopupVisibility = false;
                        });
                      },
                      onSend: () async {
                        //#TODO: send invitation logic
                        if (_formKeySendInvitation.currentState.validate()) {
                          setState(() {
                            isWaiting = true;
                          });
                          Uri uri = await database.setInvitationToFriend();
                          print(uri.toString());
                          String name = database.getCurrentUserName();
                          database.sendEmailToUser(
                            name,
                            uri,
                            invitationFriendController.text,
                          );
                          setState(() {
                            isWaiting = false;
                            invitationPopupVisibility = false;
                            invitationFriendController.clear();
                          });
                        }
                      },
                    ),
                  )),
            ),
            //report problem
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
          ],
        ),
      ),
    );
  }

  onSettingItemClick(int index) {
    switch (index) {
      case 0:
        NavigationController.push(context, PatientRegisterScreen2());
        break;
      case 1:
        setState(() {
          notificationPopupVisibility = true;
        });
        break;
      case 2:
        _openLanguagePickerDialog();
        break;
      case 3:
        setState(() {
          clientReportVisibility = true;
        });
        break;
      case 4:
        setState(() {
          invitationPopupVisibility = true;
        });
        break;
      // case 4:
      //   NavigationController.push(context, PaymentSettingPage());
      //   break;
      case 5:
        NavigationController.push(context, HelpCenterPage());
        break;
      case 6:
        setState(() {
          reportPopupVisibility = true;
        });
        break;
      case 7:
        NavigationController.push(
          context,
          WebViewPage(
            link: StringConstants.PRIVACY_POLICY_LINK,
            title: 'Privacy Policy',
          ),
        );
        break;
      case 8:
        NavigationController.push(context, AboutPage());
        break;
      case 9:
        Others.showInfoDialog(
          context: context,
          title: 'Log Out?',
          message: 'Are you sure you want to log out of the app?',
          positiveButtonLabel: 'LOG OUT',
          negativeButtonLabel: 'CANCEL',
          iInfoDialogClicked: this,
          isInfo: false,
        );
        break;

      default:
        print(index.toString());
    }
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
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
      LoginScreen(ClickType.PATIENT),
    );
  }

  //language picker dialog
  // It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration: InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: Text('Select your language'),
              onValuePicked: (Language language) => setState(() {
                _selectedDialogLanguage = language;
                print(_selectedDialogLanguage.name);
                print(_selectedDialogLanguage.isoCode);
              }),
              itemBuilder: _buildDialogItem,
            )),
      );

  //onBackpressed: first check if any dialog is visible
  onBackPressed() {
    if (notificationPopupVisibility ||
        reportPopupVisibility ||
        clientReportVisibility ||
        invitationPopupVisibility ||
        reportPopupVisibility) {
      setState(() {
        notificationPopupVisibility = false;
        reportPopupVisibility = false;
        invitationPopupVisibility = false;
        reportPopupVisibility = false;
        clientReportVisibility = false;
      });
      return false;
    } else {
      return true;
    }
  }
}

class SettingItem {
  IconData icon;
  String title;
  SettingItem({
    @required this.icon,
    @required this.title,
  });
}
