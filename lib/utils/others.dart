import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_info_dialog_clicked.dart';
import 'package:makhosi_app/contracts/i_message_dialog_clicked.dart';

class Others {
  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Widget getProfilePlaceHOlder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: Container(
          color: Colors.black12,
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.person,
            color: Colors.black12,
            size: 35,
          ),
        ),
      ),
    );
  }

  static void showMessageOptionsDialog({
    @required BuildContext context,
    @required IMessageDialogClicked iMessageDialogClicked,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Action!'),
        content: Text('What do you want to do with this message?'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              iMessageDialogClicked.onCopyClicked();
            },
            child: Text('Copy'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              iMessageDialogClicked.onDeleteClicked();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  static void showInfoDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
    @required String positiveButtonLabel,
    @required String negativeButtonLabel,
    @required IInfoDialogClicked iInfoDialogClicked,
    @required bool isInfo,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              iInfoDialogClicked.onNegativeClicked();
            },
            child: Text(
              negativeButtonLabel == null ? 'Cancel' : negativeButtonLabel,
            ),
          ),
          isInfo != null && !isInfo
              ? FlatButton(
                  onPressed: () {
                    iInfoDialogClicked.onPositiveClicked();
                  },
                  child: Text(
                    positiveButtonLabel == null
                        ? 'Confirm'
                        : positiveButtonLabel,
                  ),
                )
              : null,
        ],
      ),
    );
  }

  static Widget timingBox({@required String label}) {
    return Container(
      height: 20,
      width: 65,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 7,
            ),
        Text(
        label,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
            SizedBox(
              width: 2,
            ),
            Icon(Icons.access_time, size: 15,)
        ],
      )

      ),
    );
  }

  static SizedBox getSizedBox({
    @required double boxHeight,
    @required double boxWidth,
  }) {
    return SizedBox(
      height: boxHeight,
      width: boxWidth,
    );
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}
