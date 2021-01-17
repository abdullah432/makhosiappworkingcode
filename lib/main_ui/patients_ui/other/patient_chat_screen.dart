import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart' as rtc;
import 'package:braintree_payment/braintree_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/contracts/i_message_dialog_clicked.dart';
import 'package:makhosi_app/helper/api.dart';
import 'package:makhosi_app/main_ui/general_ui/audio_call.dart';
import 'package:makhosi_app/main_ui/general_ui/call_page.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/payment_success.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/notifications.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/permissions_handle.dart';
import 'package:uuid/uuid.dart';

class PatientChatScreen extends StatefulWidget {
  String _practitionerUid, _myUid;

  PatientChatScreen(this._practitionerUid);

  @override
  _PatientChatScreenState createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen>
    implements IMessageDialogClicked {
  List<DocumentSnapshot> _chatList = [];
  StreamSubscription _subscription;
  var _messageController = TextEditingController();
  ScrollController _controller = ScrollController();
  int _selectedPosition;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _muted = false;
  TextEditingController serviceProviderController = new TextEditingController();
  TextEditingController complainController = new TextEditingController();
  Map profile;

  @override
  void initState() {
    widget._myUid = FirebaseAuth.instance.currentUser.uid;
    _subscription = _chatStream().listen((messages) {
      _chatList.clear();
      messages.docs.forEach((message) {
        _chatList.add(message);
      });
      _scrollToEnd();
      _markAsRead();
      setState(() {});
    });
    super.initState();

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .get()
        .then((doc) async {
      var mute = false;
      try {
        mute = await doc.get('mute');
        setState(() {
          _muted = mute;
        });
      } catch (e) {
        setState(() {
          _muted = mute;
        });
      }
    });

    getProfile();
  }

  Future<void> getProfile() async {
    var snapshot = await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(widget._practitionerUid)
        .get();
    setState(() {
      profile = snapshot.data();
    });
  }

  Future<void> _sendReportServiceProvider(
      String serviceProviderName, String complain) async {
    //Now we will add message to patient section
    FirebaseFirestore.instance.collection('reports').add(
      {
        'user_type': 'CLIENT',
        'customer_name': serviceProviderName,
        'complain': complain,
        'timestamp': Timestamp.now(),
        'reported_by': widget._myUid,
        'reported_user': widget._practitionerUid,
      },
    );
  }

  Future<void> _popUpPatientDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.symmetric(vertical: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          title: Center(
            child: Text(
              'Report a Service Provider',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'To report a Service Provider, please make sure all fields are filled in',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF8A8A8F)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: serviceProviderController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEFEFF4),
                    contentPadding: EdgeInsets.all(14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    labelText: "name of service provider",
                    labelStyle: TextStyle(
                      color: Color(0xffC8C7CC),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: complainController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEFEFF4),
                    contentPadding: EdgeInsets.all(40),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    labelText: "state the reason for complaint",
                    labelStyle: TextStyle(
                      color: Color(0xffC8C7CC),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FlatButton(
                  color: AppColors.COLOR_PRIMARY,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    _sendReportServiceProvider(serviceProviderController.text,
                        complainController.text);
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _markAsRead() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .set(
      {
        'seen': true,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> _scrollToEnd() async {
    await Future.delayed(Duration(seconds: 2));
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          iconSize: 41.0,
          icon: new Icon(Icons.keyboard_arrow_left,
              color: AppColors.REVERSE_ARROW),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: AppColors.EDIT_PROFILE,
                size: 32,
              ),
              onPressed: () {
                scaffoldKey.currentState.openEndDrawer();
              })
        ],
        // context: context,
        // title: 'Messages',
        // isLeading: false,
        // targetScreen: null,
      ),
      endDrawer: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: EdgeInsets.only(top: 48),
          // padding: EdgeInsets.only(bottom: 30),
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 1.3,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0), bottom: Radius.circular(25.0)),
            child: Drawer(
              child: Container(
                color: AppColors.EDIT_PROFILE,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Voice Call',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await HandlePermission.handleMic();
                        var user = await FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget._myUid)
                            .get();

                        var channelName = uuidGenerator.v4();
                        var token = await Api.getTokenForAgora(channelName);
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._practitionerUid,
                            title:
                                'Voice call from ${user.get(AppKeys.FULL_NAME)}',
                            body: {
                              'patientUid': widget._myUid,
                              'type': 'voice',
                              'token': token,
                              'channelName': channelName
                            });
                        _sendMessage(
                            'Voice call from ${user.get(AppKeys.FULL_NAME)}',
                            'voice');
                        NavigationController.push(
                            context,
                            AudioCall(
                              channelName:
                                  token.isEmpty ? 'voice_call' : channelName,
                              role: rtc.ClientRole.Broadcaster,
                              token: token,
                            ));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.videocam,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Video Call',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        await HandlePermission.handleCamera();
                        await HandlePermission.handleMic();
                        var user = await FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget._myUid)
                            .get();
                        var channelName = uuidGenerator.v4();
                        var token = await Api.getTokenForAgora(channelName);
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._practitionerUid,
                            title:
                                'Video call from ${user.get(AppKeys.FULL_NAME)}',
                            body: {
                              'patientUid': widget._myUid,
                              'type': 'video',
                              'token': token,
                              'channelName': channelName
                            });
                        _sendMessage(
                            'Video call from ${user.get(AppKeys.FULL_NAME)}',
                            'video');
                        NavigationController.push(
                            context,
                            CallPage(
                              channelName:
                                  token.isEmpty ? 'voice_call' : channelName,
                              role: rtc.ClientRole.Broadcaster,
                              token: token,
                            ));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Delete chat history',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        _muted
                            ? Icons.notification_important
                            : Icons.notifications_off,
                        color: Colors.white,
                      ),
                      title: Text(
                        _muted ? 'Unmute notification' : 'Mute notification',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        _notifyMe(!_muted);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Save Data',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.mode_comment,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Send Review',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.confirmation_number,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Send Invoice',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.insert_drive_file,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Send Sick Note',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      leading: Icon(
                        Icons.keyboard_voice,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Voicenotes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.note_add,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Add Notes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.monetization_on,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Payment Request',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      onTap: () {
                        _popUpPatientDialog();
                      },
                      leading: Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Report Bad Service',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Share Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.block,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Report as Spam',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          ListView.builder(
            controller: _controller,
            padding: EdgeInsets.only(bottom: 80, left: 8, right: 8, top: 8),
            itemCount: _chatList.length,
            itemBuilder: (context, position) => _chatRow(position),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: _getSendMessageSection(context)),
        ],
      ),
    );
  }

  Widget sendPaymentCard(DocumentSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 3)
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You have received a payment request',
            style: TextStyle(
              color: AppColors.COLOR_PRIMARY,
              fontSize: 13,
            ),
          ),
          Text(
            'From Service Provider',
            style: TextStyle(
              color: AppColors.COLOR_PRIMARY,
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: profile != null
                ? NetworkImage(
                    profile['id_picture'],
                  )
                : AssetImage('images/circleavater.png'),
          ),
          Text(
            profile != null ? profile['first_name'] : '',
            style: TextStyle(
              color: AppColors.COLOR_PRIMARY,
              fontSize: 13,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'R${snapshot.get('amount')}',
              style: TextStyle(
                color: AppColors.COLOR_PRIMARY,
                fontSize: 13,
              ),
            ),
            Text(
              ' ZAR',
              style: TextStyle(
                color: AppColors.COLOR_PRIMARY,
                fontSize: 8,
              ),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: AppColors.COLOR_PRIMARY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  'Proceed to Pay',
                  style: TextStyle(
                    color: AppColors.COLOR_WHITE,
                    fontSize: 11,
                  ),
                ),
                onPressed: () async {
                  String clientNonce =
                      "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";
                  BraintreePayment braintreePayment = BraintreePayment();
                  var data = await braintreePayment.showDropIn(
                      nonce: clientNonce,
                      amount: snapshot.get('amount'),
                      enableGooglePay: true,
                      nameRequired: true);

                  if (data['status'] == 'success') {
                    var paymentDetails = await savePaymentTransaction(snapshot);
                    FirebaseFirestore.instance
                        .collection('chats')
                        .doc(widget._myUid)
                        .collection('inbox')
                        .doc(widget._practitionerUid)
                        .collection('messages')
                        .doc(snapshot.id)
                        .set(
                      {'paid': true},
                      SetOptions(merge: true),
                    );

                    FirebaseFirestore.instance
                        .collection('chats')
                        .doc(widget._practitionerUid)
                        .collection('inbox')
                        .doc(widget._myUid)
                        .collection('messages')
                        .doc(snapshot.get('message_ref'))
                        .set(
                      {'paid': true},
                      SetOptions(merge: true),
                    );

                    var transaction = await paymentDetails.get();
                    showPaymentSuccess(context, transaction.data());
                  }
                },
              ),
              RaisedButton(
                color: AppColors.COLOR_OFF_PRIMERY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  'Decline Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
                onPressed: () {
                  // showPaymentSuccess(context, profile, snapshot.get('amount'));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget paidCard(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 3)
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                DateFormat('d MMMM yyyy').format(data['timestamp'].toDate()),
                style: TextStyle(
                  color: AppColors.LIGHT_GREY,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: profile != null
                    ? NetworkImage(
                        profile['id_picture'],
                      )
                    : AssetImage('images/circleavater.png'),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile != null ? profile['first_name'] : '',
                    style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Payment submitted',
                    style: TextStyle(
                      color: AppColors.LIGHT_GREY,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                '+${snapshot.get('amount')}ZAR',
                style: TextStyle(
                  color: AppColors.COLOR_PRIMARY,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<DocumentReference> savePaymentTransaction(
      DocumentSnapshot snapshot) async {
    var patientProfile = await FirebaseFirestore.instance
        .collection(AppKeys.PATIENTS)
        .doc(widget._myUid)
        .get();

    var pProfile = patientProfile.data();

    var transaction = await FirebaseFirestore.instance
        .collection('passbook')
        .doc(widget._myUid)
        .collection('transactions')
        .add({
      'transactionId': Uuid().v4().characters.string,
      'sender': widget._myUid,
      'receiver': widget._practitionerUid,
      'amount': snapshot.get('amount'),
      'currency': 'ZAR',
      'senderProPic': pProfile.containsKey('profile_image')
          ? pProfile['profile_image']
          : 'images/circleavater.png',
      'receiverProPic': profile.containsKey('id_picture')
          ? profile['id_picture']
          : 'images/circleavater.png',
      'senderName': pProfile['full_name'],
      'receiverName': profile['first_name'],
      'sentOn': Timestamp.now(),
      'message': {'id': snapshot.id, ...snapshot.data()}
    });
    FirebaseFirestore.instance
        .collection('passbook')
        .doc(widget._practitionerUid)
        .collection('transactions')
        .add({
      'transactionId': Uuid().v4().characters.string,
      'sender': widget._myUid,
      'receiver': widget._practitionerUid,
      'amount': snapshot.get('amount'),
      'currency': 'ZAR',
      'senderProPic': pProfile.containsKey('profile_image')
          ? pProfile['profile_image']
          : 'images/circleavater.png',
      'receiverProPic': profile.containsKey('id_picture')
          ? profile['id_picture']
          : 'images/circleavater.png',
      'sentOn': Timestamp.now(),
      'senderName': pProfile['full_name'],
      'receiverName': profile['first_name'],
      'message': {'id': snapshot.id, ...snapshot.data()}
    });

    NotificationsUtills.sendMsgNotification(
        sender: widget._myUid,
        reciever: widget._practitionerUid,
        title:
            '${pProfile['full_name']} sent you ${snapshot.get('amount')} ZAR',
        body: {
          'patientUid': widget._myUid,
          'type': 'payment_request',
          'amount': snapshot.get('amount')
        });
    return transaction;
  }

  Widget _chatRow(int position) {
    DocumentSnapshot snapshot = _chatList[position];
    var type = snapshot.get('type');

    if (type == 'payment_request') {
      if (snapshot.get('paid')) {
        var payContainer = paidCard(snapshot);
        return payContainer;
      } else {
        var payContainer = sendPaymentCard(snapshot);
        return payContainer;
      }
    }
    return GestureDetector(
      onLongPress: () {
        Others().hideKeyboard(context);
        _selectedPosition = position;
        Others.showMessageOptionsDialog(
          context: context,
          iMessageDialogClicked: this,
        );
      },
      child: Wrap(
        alignment: snapshot.get('is_received')
            ? WrapAlignment.start
            : WrapAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
            margin: EdgeInsets.only(
              top: 4,
              left: snapshot.get('is_received') ? 0 : 24,
              right: snapshot.get('is_received') ? 24 : 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: snapshot.get('is_received')
                  ? Colors.black38
                  : AppColors.COLOR_PRIMARY,
            ),
            child: Text(
              snapshot.get('message'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget
  Widget _getSendMessageSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        height: 80,
        child: Stack(
          children: [
            Container(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                  ),
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(32),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    // borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 8,
            // ),
            Positioned(
              top: 9,
              right: 15,
              // alignment: Alignment.bottomRight,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        var user = await FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget._myUid)
                            .get();
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._practitionerUid,
                            title:
                                'Message from ${user.get(AppKeys.FULL_NAME)}',
                            message: message,
                            body: {
                              'patientUid': widget._myUid,
                              'type': 'text'
                            });
                        _sendMessage(message, 'text');
                      }
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.EDIT_PROFILE,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        var user = await FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget._myUid)
                            .get();
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._practitionerUid,
                            title:
                                'Message from ${user.get(AppKeys.FULL_NAME)}',
                            message: message,
                            body: {
                              'patientUid': widget._myUid,
                              'type': 'text',
                            });
                        _sendMessage(message, 'text');
                      }
                    },
                    child: Icon(
                      Icons.mood,
                      color: AppColors.EDIT_PROFILE,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        var user = await FirebaseFirestore.instance
                            .collection('patients')
                            .doc(widget._myUid)
                            .get();
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._practitionerUid,
                            title:
                                'Message from ${user.get(AppKeys.FULL_NAME)}',
                            message: message,
                            body: {
                              'patientUid': widget._myUid,
                              'type': 'text',
                            });
                        _sendMessage(message, 'text');
                      }
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.EDIT_PROFILE,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     String message = _messageController.text.trim();
            //     if (message.isNotEmpty) {
            //       _sendMessage(message);
            //     }
            //   },
            //   child: Icon(
            //     Icons.send,
            //     color: AppColors.COLOR_PRIMARY,
            //     size: 40,
            //   ),
            // ),
            // SizedBox(
            //   width: 8,
            // ),
            // GestureDetector(
            //   onTap: () async {
            //     await [Permission.camera, Permission.microphone].request();
            //     NavigationController.push(
            //       context,
            //       CallPage(widget._practitionerUid, ClientRole.Broadcaster),
            //     );
            //   },
            //   child: Icon(
            //     Icons.video_call,
            //     color: AppColors.COLOR_PRIMARY,
            //     size: 40,
            //   ),
            // ),
          ],
        ),
        // ),
      ),
    );
  }

  void _notifyMe(bool mute) {
    //First we will update inbox data for patient i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .set(
      {
        'mute': mute,
      },
      SetOptions(
        merge: true,
      ),
    );

    setState(() {
      _muted = mute;
    });
  }

  Future<void> _sendMessage(String message, String type) async {
    //First we will update inbox data for patient i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': message,
        'seen': true,
        'mute': _muted,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to patient section
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': message,
        'type': type,
        'is_received': false,
      },
    );
    //Now we will update inbox data for practitioner i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._practitionerUid)
        .collection('inbox')
        .doc(widget._myUid)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': message,
        'seen': false,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to practitioner section
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._practitionerUid)
        .collection('inbox')
        .doc(widget._myUid)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': message,
        'type': type,
        'is_received': true,
      },
    );
    _messageController.text = '';
    Others().hideKeyboard(context);
  }

  Stream<QuerySnapshot> _chatStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void onCopyClicked() async {
    await Clipboard.setData(
      ClipboardData(
        text: _chatList[_selectedPosition].get('message'),
      ),
    );
    AppToast.showToast(message: 'Copied to clipboard');
  }

  @override
  void onDeleteClicked() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._practitionerUid)
        .collection('messages')
        .doc(_chatList[_selectedPosition].id)
        .delete();
  }
}
