import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/chat/practitioner_chat_screen.dart';
import 'package:makhosi_app/models/inbox_model.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';

class Consultations extends StatefulWidget {
  final File image;

  Consultations({this.image});
  @override
  _ConsultationsState createState() => _ConsultationsState();
}

enum Sort { onlineClient, newClient, oldClient }

class _ConsultationsState extends State<Consultations> {
  List<InboxModel> _inboxList = [];
  StreamSubscription _subscription;
  String _uid;

  Sort _sortBy = Sort.onlineClient;
  bool isLoading = true;

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
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Stream<QuerySnapshot> _inboxStream() {
    switch (_sortBy) {
      case Sort.oldClient:
        setState(() {
          isLoading = true;
        });
        return FirebaseFirestore.instance
            .collection('chats')
            .doc(_uid)
            .collection('inbox')
            .orderBy('timestamp', descending: false)
            .snapshots();
      case Sort.newClient:
        setState(() {
          isLoading = true;
        });
        return FirebaseFirestore.instance
            .collection('chats')
            .doc(_uid)
            .collection('inbox')
            .orderBy('timestamp', descending: true)
            .snapshots();
      case Sort.onlineClient:
        setState(() {
          isLoading = true;
        });
        return FirebaseFirestore.instance
            .collection('chats')
            .doc(_uid)
            .collection('inbox')
            .orderBy('timestamp', descending: true)
            .snapshots();
      default:
        setState(() {
          isLoading = true;
        });
        return FirebaseFirestore.instance
            .collection('chats')
            .doc(_uid)
            .collection('inbox')
            .orderBy('timestamp', descending: true)
            .snapshots();
    }
  }

  Future<void> _getSenderProfile(int position) async {
    _inboxList[position].senderProfileSnapshot = await FirebaseFirestore
        .instance
        .collection('patients')
        .doc(_inboxList[position].inBoxSnapshot.id)
        .get();
    setState(() {});
  }

  Widget createbox(int position) {
    InboxModel model = _inboxList[position];
    // String lastMessage = model.inBoxSnapshot.get('last_message');
    // Timestamp timestamp = model.inBoxSnapshot.get('timestamp');
    // lastMessage = lastMessage.length > 20
    //     \? '${lastMessage.substring(0, 19)}...'
    //     : lastMessage;

    if (model.senderProfileSnapshot == null) {
      _getSenderProfile(position);
    }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            NavigationController.push(
              context,
              PractitionerChatScreen(model.inBoxSnapshot.id,image: widget.image,),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 7,
                  color: Colors.grey[100],
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.senderProfileSnapshot != null
                      ? model.senderProfileSnapshot.get('full_name')
                      : '',
                  style: TextStyle(
                    color: AppColors.SMALL_TEXT,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: null,
          // leading: IconButton(
          //   iconSize: 41.0,
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () {
          //     Navigator.pop(context);
          // },
          // ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.arrow_forward),
            //   iconSize: 41,
            //   color: Colors.black,
            //   tooltip: 'Increase volume by 10',
            //   onPressed: () {
            //     setState(() {});
            //   },
            // ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Text(
                  'Today ‘s sessions',
                  style: TextStyle(
                    color: AppColors.BOLDTEXT_COLOR,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'New Clients and In-Person',
                  style: TextStyle(
                    color: AppColors.NORMAL_TEXT,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
                leading: Radio(
                  value: Sort.newClient,
                  groupValue: _sortBy,
                  onChanged: (newCli) {
                    setState(() {
                      _sortBy = newCli;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Online',
                  style: TextStyle(
                    color: AppColors.NORMAL_TEXT,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
                leading: Radio(
                  value: Sort.onlineClient,
                  groupValue: _sortBy,
                  onChanged: (onli) {
                    setState(() {
                      _sortBy = onli;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Old Clients',
                  style: TextStyle(
                    color: AppColors.NORMAL_TEXT,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
                leading: Radio(
                  value: Sort.oldClient,
                  groupValue: _sortBy,
                  onChanged: (old) {
                    setState(() {
                      _sortBy = old;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _inboxList.length,
                        itemBuilder: (context, position) => createbox(position),
                      ),
              ),
            ],
          ),
        )
        // ],
        // )),
        );
  }
}
