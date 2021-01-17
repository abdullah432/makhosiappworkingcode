import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesModel {
  String _healerUid;
  DocumentSnapshot _snapshot;

  String get healerUid => _healerUid;

  set healerUid(String value) {
    _healerUid = value;
  }

  DocumentSnapshot get snapshot => _snapshot;

  set snapshot(DocumentSnapshot value) {
    _snapshot = value;
  }
}
