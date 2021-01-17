import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class NotificationsUtills {
  static const _serverKey =
      'AAAAS08uemo:APA91bGPw1A53sSi8t-3lrKBsACy95fvXStnmfI7mZv-peUDlELFjPqw5mxxFhNTxE55ky_7tj9z_o0Zz1yueBVGinujxwHxEmneZmSV87Ow_3MpOgDuZusBTTGFmlBpXAI5qQqDz6iX';

  static Future<void> sendMsgNotification(
      {String sender,
        String reciever,
        String title,
        String message,
        Map body}) async {
    var recieverInbox = await FirebaseFirestore.instance
        .collection('chats')
        .doc(reciever)
        .collection('inbox')
        .doc(sender)
        .get();
    var rIb = recieverInbox.data();
    var isMuted = rIb.containsKey('mute') ? recieverInbox.get('mute') : false;
    if (!isMuted) {
      var data = <String, dynamic>{
        'notification': message == null
            ? <String, dynamic>{
          'title': title,
        }
            : <String, dynamic>{'title': title, 'body': message},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          ...body,
        },
        'to': '/topics/messages_$reciever',
      };
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverKey',
        },
        body: jsonEncode(data),
      );
    }
  }
}