import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/global_data.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class RegisterHelper {
  String _uid = GlobalData.useruid;

  Future<bool> uploadImage({
    @required PickedFile pickedFile,
    @required ClickType userType,
  }) async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child('user_ids/$_uid.jpg');
    StorageUploadTask task = ref.putFile(File(pickedFile.path));
    var result = await task.onComplete;
    String downloadUrl = await result.ref.getDownloadURL();
    return await _uploadProfilePicture(downloadUrl, userType);
  }

  Future<bool> _uploadProfilePicture(
      String downloadUrl, ClickType userType) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            userType == ClickType.PATIENT
                ? AppKeys.PATIENTS
                : userType == ClickType.PRACTITIONER
                    ? AppKeys.PRACTITIONERS
                    : AppKeys.SHOP_OWNERS,
          )
          .doc(_uid)
          .set(
        {AppKeys.ID_PICTURE: downloadUrl},
        SetOptions(merge: true),
      );
      print('image uploaded');
      return true;
    } catch (exc) {
      return false;
    }
  }

  Future<bool> updateTraditionalHealerDataToFirestore({
    @required Map<String, Object> userInfoMap,
  }) async {
  /*  try {
      await FirebaseFirestore.instance
          .collection(AppKeys.PRACTITIONERS)
          .doc(_uid)
          .set(userInfoMap);
      return true;
    } catch (exc) {
      AppToast.showToast(message: exc.toString());
      return false;
    }*/
  }


  Future<bool> savePatientDataToFirestore({
    @required Map<String, Object> userInfoMap,
    @required ClickType userType,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(
            userType == ClickType.PATIENT
                ? AppKeys.PATIENTS
                : userType == ClickType.PRACTITIONER
                    ? AppKeys.PRACTITIONERS
                    : AppKeys.SHOP_OWNERS,
          )
          .doc(_uid)
          .set(userInfoMap);
      return true;
    } catch (exc) {
      AppToast.showToast(message: exc.toString());
      return false;
    }
  }
  Future<bool> savePatientDataToFirestore2({
    @required Map<String, Object> userInfoMap,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(
         AppKeys.PRACTITIONERS
      )
          .doc(_uid)
          .set(userInfoMap);
      return true;
    } catch (exc) {
      AppToast.showToast(message: exc.toString());
      return false;
    }
  }

  Future<bool> registerUser({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _uid = authResult.user.uid;
      GlobalData.useruid = _uid;
      return true;
    } catch (exc) {
      AppToast.showToast(message: exc.message);
      return false;
    }
  }

  bool validateUser({
    @required String name,
    @required String email,
    @required String password,
    @required String address,
    @required String phone,
    @required String selectedGender,
    @required String dateOfBirth,
  }) {
    if (name.isEmpty) {
      AppToast.showToast(message: 'Name cannot be empty');
      return false;
    } else if (email.isEmpty) {
      AppToast.showToast(message: 'Email cannot be empty');
      return false;
    } else if (password.isEmpty) {
      AppToast.showToast(message: 'Password cannot be empty');
      return false;
    } else if (password.length < 6) {
      AppToast.showToast(message: 'Password length cannot be less than 6');
      return false;
    } else if (address.isEmpty) {
      AppToast.showToast(message: 'Address cannot be empty');
      return false;
    } else if (phone.isEmpty) {
      AppToast.showToast(message: 'Phone number cannot be empty');
      return false;
    } else if (selectedGender == StringConstants.SELECTED_GENDER) {
      AppToast.showToast(message: 'Select a gender first');
      return false;
    } else if (dateOfBirth == StringConstants.DATE_OF_BIRTH) {
      AppToast.showToast(message: 'Select birth date first');
      return false;
    } else {
      return true;
    }
  }
}
