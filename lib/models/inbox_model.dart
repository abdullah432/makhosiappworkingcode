import 'package:cloud_firestore/cloud_firestore.dart';

class InboxModel {
  DocumentSnapshot _inBoxSnapshot;
  DocumentSnapshot _senderProfileSnapshot;

  DocumentSnapshot get inBoxSnapshot => _inBoxSnapshot;

  set inBoxSnapshot(DocumentSnapshot value) {
    _inBoxSnapshot = value;
  }

  DocumentSnapshot get senderProfileSnapshot => _senderProfileSnapshot;

  set senderProfileSnapshot(DocumentSnapshot value) {
    _senderProfileSnapshot = value;
  }
}
