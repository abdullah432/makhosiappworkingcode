import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class AddNewPostScreen extends StatefulWidget {
  @override
  _AddNewPostScreenState createState() => _AddNewPostScreenState();
}

class _AddNewPostScreenState extends State<AddNewPostScreen>
    implements IRoundedButtonClicked {
  PickedFile _pickedFile;
  var _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbars.toolbar(
        context: context,
        title: 'Add Post',
        isLeading: false,
        targetScreen: null,
      ),
      body: Stack(
        children: [
          _getBody(),
          _isLoading
              ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
              : Container(),
        ],
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                _pickedFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  imageQuality: 25,
                );
                setState(() {});
              },
              child: Container(
                width: ScreenDimensions.getScreenWidth(context),
                height: 250,
                color: Colors.black12,
                child: _pickedFile == null
                    ? Icon(
                        Icons.image,
                        size: 120,
                        color: Colors.black26,
                      )
                    : Image.file(
                        File(_pickedFile.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Post Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'Add',
              clickType: ClickType.DUMMY,
            ),
          ],
        ),
      ),
    );
  }

  @override
  onClick(ClickType clickType) {
    String description = _descriptionController.text.trim();
    if (_pickedFile == null) {
      AppToast.showToast(message: 'Image must be selected');
    } else if (description.isEmpty) {
      AppToast.showToast(message: 'Description cannot be empty');
    } else {
      setState(() {
        _isLoading = true;
      });
      String postID =
          FirebaseFirestore.instance.collection('blog_posts').doc().id;
      StorageReference ref =
          FirebaseStorage.instance.ref().child('post_images/$postID.jpg');
      StorageUploadTask task = ref.putFile(File(_pickedFile.path));
      task.onComplete.then((_) async {
        FirebaseFirestore.instance.collection('blog_posts').doc(postID).set({
          'description': description,
          'image_url': await _.ref.getDownloadURL(),
          'post_by_uid': FirebaseAuth.instance.currentUser.uid,
        }).then((response) {
          Navigator.pop(context);
        }).catchError((error) {
          setState(() {
            _isLoading = false;
            AppToast.showToast(message: error.toString());
          });
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          AppToast.showToast(message: error.toString());
        });
      });
    }
  }
}
