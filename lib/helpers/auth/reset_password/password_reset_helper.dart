import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_toast.dart';

class PasswordResetHelper {
  bool validateLoginCredentials({
    @required String email,
  }) {
    if (email.isEmpty) {
      AppToast.showToast(message: 'Email cannot be empty');
      return false;
    } else {
      return true;
    }
  }

  Future<void> sendPasswordResetLink({
    @required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      AppToast.showToast(message: 'Reset link sent');
    } catch (exc) {
      AppToast.showToast(message: exc.message);
    }
  }
}
