import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsModel {
  String _practitionerUid, _patientUid;
  DocumentSnapshot _profileSnapshot, _bookingSnapshot;

  String get practitionerUid => _practitionerUid;

  set practitionerUid(String value) {
    _practitionerUid = value;
  }

  get patientUid => _patientUid;

  set patientUid(value) {
    _patientUid = value;
  }

  get bookingSnapshot => _bookingSnapshot;

  set bookingSnapshot(value) {
    _bookingSnapshot = value;
  }

  DocumentSnapshot get profileSnapshot => _profileSnapshot;

  set profileSnapshot(DocumentSnapshot value) {
    _profileSnapshot = value;
  }
}
