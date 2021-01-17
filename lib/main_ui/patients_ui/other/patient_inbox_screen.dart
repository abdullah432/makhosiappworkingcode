import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patient_chat_screen.dart';
import 'package:makhosi_app/models/inbox_model.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class PractitionerInboxScreen extends StatefulWidget {
  @override
  _PractitionerInboxScreenState createState() =>
      _PractitionerInboxScreenState();
}

class _PractitionerInboxScreenState extends State<PractitionerInboxScreen> {
  List<InboxModel> _inboxList = [];
  bool _isLoading = true;
  StreamSubscription _subscription;
  String _uid;

  @override
  void initState() {
    _uid = FirebaseAuth.instance.currentUser.uid;
    _subscription = _inboxStream().listen((inbox) {
      _inboxList.clear();
      inbox.docs.forEach((snapshot) {
        InboxModel model = InboxModel();
        model.inBoxSnapshot = snapshot;
        _inboxList.add(model);
      });
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbars.toolbar(
        context: context,
        title: 'Inbox',
        isLeading: false,
        targetScreen: null,
      ),
      body: _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : _inboxList.isEmpty
              ? AppStatusComponents.errorBody(message: 'Inbox empty')
              : _getBody(),
    );
  }

  Widget _getBody() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _inboxList.length,
      itemBuilder: (context, position) => _rowDesign(position),
    );
  }

  Widget _rowDesign(int position) {
    InboxModel model = _inboxList[position];
    String lastMessage = model.inBoxSnapshot.get('last_message');
    Timestamp timestamp = model.inBoxSnapshot.get('timestamp');
    Map profile = {};
    lastMessage = lastMessage.length > 20
        ? '${lastMessage.substring(0, 19)}...'
        : lastMessage;
    if (model.senderProfileSnapshot == null) {
      _getSenderProfile(position)
          .then((value) => profile = model.senderProfileSnapshot.data());
    }
    return GestureDetector(
      onTap: () {
        NavigationController.push(
          context,
          PatientChatScreen(model.inBoxSnapshot.id),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        width: ScreenDimensions.getScreenWidth(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                model.senderProfileSnapshot == null
                    ? Others.getProfilePlaceHOlder()
                    : !profile.containsKey('id_picture')
                        ? Others.getProfilePlaceHOlder()
                        : CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              model.senderProfileSnapshot.get('id_picture'),
                            ),
                          ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.senderProfileSnapshot == null
                                  ? ''
                                  : '${profile.containsKey('full_name') ? model.senderProfileSnapshot.get('full_name') : ""}',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${timestamp.toDate().hour}:${timestamp.toDate().minute}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lastMessage,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                !model.inBoxSnapshot.get('seen')
                    ? SizedBox(
                        width: 8,
                      )
                    : Container(),
                model.inBoxSnapshot.get('seen')
                    ? Container()
                    : Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 12,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getSenderProfile(int position) async {
    _inboxList[position].senderProfileSnapshot = await FirebaseFirestore
        .instance
        .collection('practitioners')
        .doc(_inboxList[position].inBoxSnapshot.id)
        .get();
    setState(() {});
  }

  Stream<QuerySnapshot> _inboxStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(_uid)
        .collection('inbox')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
