import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:makhosi_app/main_ui/general_ui/audio_call.dart';
import 'package:makhosi_app/main_ui/general_ui/call_page.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/chat/practitioner_chat_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/pickup_call_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';
import 'package:makhosi_app/utils/app_keys.dart';

class PractitionersHome extends StatefulWidget {
  @override
  _PractitionersHomeState createState() => _PractitionersHomeState();
}

class _PractitionersHomeState extends State<PractitionersHome> {
  dynamic _snapshot;
  bool _isLoading = true;
  String _error;

  @override
  void initState() {
    print('ggv');
    FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        print(value.data());
        _snapshot = value.data();
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _error = error.toString();
      });
    });
    super.initState();
    context.read<NotificationProvider>().firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        List msgArr = message['notification']['title'].split(" ");
        if (Platform.isIOS) {
        } else {
          switch (message['data']['type']) {
            case 'voice':
              NavigationController.push(
                  context,
                  PickupCall(
                    title: 'Incoming Voice Call',
                    label: msgArr.last,
                    type: 'voice',
                    channelName: message['data']['channelName'],
                    token: message['data']['token'],
                  ));

              break;
            case 'video':
              NavigationController.push(
                  context,
                  PickupCall(
                    title: 'Incoming Video Call',
                    label: msgArr.last,
                    type: 'video',
                    channelName: message['data']['channelName'],
                    token: message['data']['token'],
                  ));
              break;
            case 'text':
              context.read<NotificationProvider>().showNotification(
                  message['notification']['title'],
                  message['notification']['body']);

              break;
            default:
          }
        }

        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        if (Platform.isIOS) {
        } else {
          switch (message['data']['type']) {
            case 'voice':
              NavigationController.push(
                  context,
                  AudioCall(
                    channelName: message['data']['token'].isEmpty
                        ? 'voice_call'
                        : message['data']['channelName'],
                    role: ClientRole.Broadcaster,
                    token: message['data']['token'],
                  ));
              break;
            case 'video':
              NavigationController.push(
                  context,
                  CallPage(
                      channelName: message['data']['token'].isEmpty
                          ? 'voice_call'
                          : message['data']['channelName'],
                      role: ClientRole.Broadcaster,
                      token: message['data']['token']));
              break;
            case 'text':
              NavigationController.push(context,
                  PractitionerChatScreen(message['data']['patientUid']));

              break;
            default:
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        if (Platform.isIOS) {
        } else {
          switch (message['data']['type']) {
            case 'voice':
              NavigationController.push(
                  context,
                  AudioCall(
                      channelName: message['data']['token'].isEmpty
                          ? 'voice_call'
                          : message['data']['channelName'],
                      role: ClientRole.Broadcaster,
                      token: message['data']['token']));
              break;
            case 'video':
              NavigationController.push(
                  context,
                  CallPage(
                      channelName: message['data']['token'].isEmpty
                          ? 'voice_call'
                          : message['data']['channelName'],
                      role: ClientRole.Broadcaster,
                      token: message['data']['token']));
              break;
            case 'text':
              NavigationController.push(context,
                  PractitionerChatScreen(message['data']['patientUid']));
              break;
            default:
          }
        }
      },
    );
    // context.read<NotificationProvider>().firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     if (Platform.isIOS) {
    //     } else {}

    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");

    //     if (Platform.isIOS) {
    //     } else {
    //       NavigationController.push(
    //           context, PractitionerChatScreen(message['data']['patientUid']));
    //     }
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");

    //     if (Platform.isIOS) {
    //     } else {
    //       NavigationController.push(
    //           context, PractitionerChatScreen(message['data']['patientUid']));
    //     }
    //   },
    // );
  }

  onMessageDialog(
      {BuildContext context, String title, String label, Function onAccept}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(label),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Reject'),
          ),
          FlatButton(
            onPressed: onAccept,
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
        : _error != null
            ? AppStatusComponents.errorBody(message: _error)
            : PractitionersProfileScreen(false, _snapshot);
  }
}
