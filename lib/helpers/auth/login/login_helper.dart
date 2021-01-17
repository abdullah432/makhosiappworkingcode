import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';

class LoginHelper {
  bool validateLoginCredentials({
    @required String email,
    @required String password,
  }) {
    if (email.isEmpty) {
      AppToast.showToast(message: 'Email cannot be empty');
      return false;
    } else if (password.isEmpty) {
      AppToast.showToast(message: 'Password cannot be empty');
      return false;
    } else if (password.length < 6) {
      AppToast.showToast(message: 'Password length is less than 6 characters');
      return false;
    } else {
      return true;
    }
  }

  Future<bool> loginUser({
    @required String email,
    @required String password,
    @required ClickType userType,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String uid = FirebaseAuth.instance.currentUser.uid;
      DocumentSnapshot snapshot = await (userType == ClickType.PRACTITIONER
              ? FirebaseFirestore.instance.collection(AppKeys.PRACTITIONERS).doc(uid)
              : FirebaseFirestore.instance.collection('patients').doc(uid))
          .get();
      if (userType == ClickType.PRACTITIONER) {
        await FirebaseFirestore.instance
            .collection(AppKeys.PRACTITIONERS)
            .doc(FirebaseAuth.instance.currentUser.uid)
            .set({
          'online': true,
        }, SetOptions(merge: true));
      }
      if (!snapshot.exists) {
        AppToast.showToast(message: 'Account not allowed');
      }
      return snapshot.exists;
    } catch (exc) {
      AppToast.showToast(message: exc.message);
      return false;
    }
  }

  Future<DocumentSnapshot> _getUserData({
    @required DocumentReference documentReference,
  }) async {
    return await documentReference.get();
  }

  Future<bool> loginUsingGoogle() async {
     try {
    UserCredential userCredential;
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential =
        await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('patients')
        .doc(userCredential.user.uid)
        .get();
    if (userSnapshot.exists) {
      return true;
    } else {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(userCredential.user.uid)
          .set({
        AppKeys.FULL_NAME: googleUser.displayName,
        AppKeys.EMAIL: googleUser.email,
        AppKeys.PROFILE_IMAGE: googleUser.photoUrl,
        AppKeys.ADDRESS: null,
        AppKeys.PHONE_NUMBER: null,
        AppKeys.GENDER: null,
        AppKeys.DATE_OF_BIRTH: null,
      });
      return true;
    }
    } catch (e) {
       print(e);
       return false;
     }
  }
}
