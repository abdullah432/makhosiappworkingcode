import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_dialogue_button_clicked.dart';
import 'package:makhosi_app/ui/customstoragepopup.dart';
import 'package:makhosi_app/ui/earningpopup.dart';
import 'package:makhosi_app/ui/newfolder_popup.dart.dart';
import 'package:makhosi_app/ui/noofclientspopup.dart';

class AppDialogues {
  static void showConfirmationDialogue({
    @required BuildContext context,
    @required String title,
    @required String label,
    @required String negativeButtonLabel,
    @required String positiveButtonLabel,
    @required IDialogueButtonClicked iDialogueButtonClicked,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(label),
        actions: [
          FlatButton(
            onPressed: () {
              iDialogueButtonClicked.onNegativeClicked();
            },
            child: Text(negativeButtonLabel),
          ),
          FlatButton(
            onPressed: () {
              iDialogueButtonClicked.onPositiveClicked();
            },
            child: Text(positiveButtonLabel),
          ),
        ],
      ),
    );
  }

  static showNewFolderPopup(context, controller, {onCreateFolder}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomNewFolderDialogBox(
          // formKey: formKey,
          folderNameController: controller,
          onCreateFolder: onCreateFolder,
        );
      },
    );
  }

  static showUpgradeStoragePopup(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomUpgradeStorageDialogBox();
      },
    );
  }

  static showNoOfClientsPopup(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoOfClientsDialogBox();
      },
    );
  }

  static showEarningPopup(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EarningDialogBox();
      },
    );
  }
}
