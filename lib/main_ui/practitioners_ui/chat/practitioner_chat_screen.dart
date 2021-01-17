import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart' as rtc;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/contracts/i_dialogue_button_clicked.dart';
import 'package:makhosi_app/contracts/i_message_dialog_clicked.dart';
import 'package:makhosi_app/helper/api.dart';
import 'package:makhosi_app/main_ui/backend/fullphoto.dart';
import 'package:makhosi_app/main_ui/general_ui/audio_call.dart';
import 'package:makhosi_app/main_ui/general_ui/call_page.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/chat/payment_request.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_dialogues.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/notifications.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/permissions_handle.dart';
import 'package:path/path.dart' as path;

class PractitionerChatScreen extends StatefulWidget {
  String _patientUid, _myUid;
  File image;


  PractitionerChatScreen(this._patientUid,{this.image});

  @override
  _PractitionerChatScreenState createState() => _PractitionerChatScreenState();
}

class _PractitionerChatScreenState extends State<PractitionerChatScreen>
    implements IMessageDialogClicked, IDialogueButtonClicked {
  List<DocumentSnapshot> _chatList = [];
  StreamSubscription _subscription;
  var _messageController = TextEditingController();
  ScrollController _controller = ScrollController();
  int _selectedPosition;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _muted = false;
  TextEditingController _amountToReq = TextEditingController();
  bool isAbelapi = false;
  TextEditingController customerNameController = new TextEditingController();
  TextEditingController complainController = new TextEditingController();
  DocumentSnapshot profile;

  String messageType;

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
      _getServiceType();

      setState(() {});
    });
    super.initState();

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._patientUid)
        .get()
        .then((doc) {
      var d = doc.data();
      var mute = d.containsKey('mute') ? doc.get('mute') : false;
      setState(() {
        _muted = mute;
      });
    });
  }

  Future<void> _sendReportCoustomer(
      String customerName, String complain) async {
    //Now we will add message to patient section
    FirebaseFirestore.instance.collection('reports').add(
      {
        'user_type': 'SERVICE_PROVIDER',
        'customer_name': customerName,
        'complain': complain,
        'timestamp': Timestamp.now(),
        'reported_by': widget._myUid,
        'reported_user': widget._patientUid,
      },
    );
  }

  Future<void> _popUpServiceProviderDialog() async {
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
              'Report a Customer/Client',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'To report a Customer/Client, please make sure all fields are filled in',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF8A8A8F)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: customerNameController,
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
                    labelText: "name of customer/client",
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
                    _sendReportCoustomer(
                        customerNameController.text, complainController.text);
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
        .doc(widget._patientUid)
        .set(
      {
        'seen': true,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> _getServiceType() async {
    var serviceProvider = await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(widget._myUid)
        .get();
    var type = serviceProvider.get("service_type");

    setState(() {
      profile = serviceProvider;
    });

    if (type.toLowerCase() == "Abelaphi".toLowerCase()) {
      setState(() {
        isAbelapi = true;
      });
    }
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
        leading: IconButton(
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
      //  AppToolbars.toolbar(
      //   context: context,
      //   title: 'Messages',
      //   isLeading: false,
      //   targetScreen: null,
      // ),
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
                            .collection(AppKeys.PRACTITIONERS)
                            .doc(widget._myUid)
                            .get();
                        var channelName = uuidGenerator.v4();
                        var token = await Api.getTokenForAgora(channelName);
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._patientUid,
                            title:
                                'Voice call from ${user.get(AppKeys.FIRST_NAME)}',
                            body: {
                              'practitionerUid': widget._myUid,
                              'type': 'voice',
                              'token': token,
                              'channelName': channelName
                            });
                        _sendMessage(
                            'Voice call from ${user.get(AppKeys.FIRST_NAME)}',
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
                            .collection(AppKeys.PRACTITIONERS)
                            .doc(widget._myUid)
                            .get();
                        var channelName = uuidGenerator.v4();
                        var token = await Api.getTokenForAgora(channelName);
                        NotificationsUtills.sendMsgNotification(
                            sender: widget._myUid,
                            reciever: widget._patientUid,
                            title:
                                'Video call from ${user.get(AppKeys.FIRST_NAME)}',
                            body: {
                              'practitionerUid': widget._myUid,
                              'type': 'video',
                              'token': token,
                              'channelName': channelName
                            });
                        _sendMessage(
                            'Video call from ${user.get(AppKeys.FIRST_NAME)}',
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
                      onTap: () {
                        AppDialogues.showConfirmationDialogue(
                            context: context,
                            title: 'Are you sure?',
                            label: 'Your chat history will be gone for good.',
                            negativeButtonLabel: 'Cancel',
                            positiveButtonLabel: 'Delete',
                            iDialogueButtonClicked: this);
                      },
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
                    ListTile(
                      leading: Icon(
                        Icons.confirmation_number,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Send Invoice',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    (isAbelapi)
                        ? ListTile(
                            leading: Icon(
                              Icons.insert_drive_file,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Send Sick Note',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
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
                        'Add Session Notes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Payment Request',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        NavigationController.push(
                            context,
                            PaymentRequest(
                              sender: widget._myUid,
                              reciever: widget._patientUid,
                            ));
                      },
                    ),
                    ListTile(
                      onTap: () {
                        _popUpServiceProviderDialog();
                      },
                      leading: Icon(
                        Icons.report,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Report Customer',
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
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.block,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Report as Spam',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: _getBody(),
    );
  }

  Widget paidCard(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    var pr = profile?.data();
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
                        pr['id_picture'],
                      )
                    : AssetImage('images/circleavater.png'),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile != null ? pr['first_name'] : '',
                    style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    data['paid'] ? 'Payment received' : 'Pending',
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

  Widget _getBody() {
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
          _getSendMessageSection(),
        ],
      ),
    );
  }

  Widget _chatRow(int position) {
    DocumentSnapshot snapshot = _chatList[position];

    var type = snapshot.get('type');

    if (type == 'payment_request') {
      var payContainer = paidCard(snapshot);
      return payContainer;
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
          snapshot.get('messageType')=='image'?_imageMessage(snapshot.get('message'), context,snapshot.get('is_received')):Container(
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

  Widget _getSendMessageSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          (widget.image!=null)?Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
                onTap: (){
                  // messageType = 'image';
                  uploadChatImage(context,widget.image).then((value)async{
                    await _sendMessage(value,'image');
                  });
                },
                child: Text('Send Invoice',style: TextStyle(color: AppColors.COLOR_PRIMARY,fontSize: 18,fontWeight: FontWeight.w600),)),
          ):Container(),
          Container(
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
                                .collection(AppKeys.PRACTITIONERS)
                                .doc(widget._myUid)
                                .get();

                            NotificationsUtills.sendMsgNotification(
                                sender: widget._myUid,
                                reciever: widget._patientUid,
                                title:
                                    'Message from ${user.get(AppKeys.FIRST_NAME)}',
                                message: message,
                                body: {
                                  'practitionerUid': widget._myUid,
                                  'type': 'text',
                                });
                            _sendMessage(message, 'text');
                            Others().hideKeyboard(context);
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
                                .collection(AppKeys.PRACTITIONERS)
                                .doc(widget._myUid)
                                .get();

                            NotificationsUtills.sendMsgNotification(
                                sender: widget._myUid,
                                reciever: widget._patientUid,
                                title:
                                    'Message from ${user.get(AppKeys.FIRST_NAME)}',
                                message: message,
                                body: {
                                  'practitionerUid': widget._myUid,
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
                                .collection(AppKeys.PRACTITIONERS)
                                .doc(widget._myUid)
                                .get();

                            NotificationsUtills.sendMsgNotification(
                                sender: widget._myUid,
                                reciever: widget._patientUid,
                                title:
                                    'Message from ${user.get(AppKeys.FIRST_NAME)}',
                                message: message,
                                body: {
                                  'practitionerUid': widget._myUid,
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
              ],
            ),
            // child: Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: _messageController,
            //         decoration: InputDecoration(
            //           hintText: 'Message...',
            //           hintStyle: TextStyle(
            //             fontSize: 13,
            //           ),
            //           contentPadding: EdgeInsets.all(12),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(32),
            //             borderSide: BorderSide(color: Colors.black26),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(32),
            //             borderSide: BorderSide(color: Colors.black38),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         String message = _messageController.text.trim();
            //         if (message.isNotEmpty) {
            //           _sendMessage(message);
            //         }
            //       },
            //       child: Icon(
            //         Icons.send,
            //         color: AppColors.COLOR_PRIMARY,
            //         size: 40,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 8,
            //     ),
            //     GestureDetector(
            //       onTap: () async {
            //         await [Permission.camera, Permission.microphone].request();
            //         NavigationController.push(
            //           context,
            //           CallPage(widget._myUid, ClientRole.Broadcaster),
            //         );
            //       },
            //       child: Icon(
            //         Icons.video_call,
            //         color: AppColors.COLOR_PRIMARY,
            //         size: 40,
            //       ),
            //     ),
            //   ],
            // ),
            //   ),
          ),
        ],
      ),
    );
  }

  void _notifyMe(bool mute) {
    //First we will update inbox data for patient i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._patientUid)
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
        .doc(widget._patientUid)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': message,
        'seen': true,
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
        .doc(widget._patientUid)
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
        .doc(widget._patientUid)
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
        .doc(widget._patientUid)
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
  }

  Stream<QuerySnapshot> _chatStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget._myUid)
        .collection('inbox')
        .doc(widget._patientUid)
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
        .doc(widget._patientUid)
        .collection('messages')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() {
    Navigator.pop(context);
    Navigator.pop(context);

    this.onDeleteClicked();
  }

  Future<String> uploadChatImage(BuildContext context, File image) async {
    String fileName = path.basename(image.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Invoice/${widget._myUid}/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    String url = await firebaseStorageRef.getDownloadURL();
    return url;
  }

  Widget _imageMessage(imageUrlFromFB,context,bool check) {
    return Container(
      width: 160,
      height: 160,
      padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
      margin: EdgeInsets.only(
          top: 15,
          left: check ? 0 : 24,
          right: check ? 24 : 0,
          bottom: 15
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.COLOR_PRIMARY)
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FullPhoto(url: imageUrlFromFB)));
        },
        child: CachedNetworkImage(
          imageUrl: imageUrlFromFB,
          placeholder: (context, url) => Container(
            transform: Matrix4.translationValues(0, 0, 0),
            child: Container( width: 60, height: 80,
                child: Center(child: new CircularProgressIndicator())),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          width: 60,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
