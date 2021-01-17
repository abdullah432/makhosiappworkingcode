import 'package:flutter/material.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';

class CustomNewFolderDialogBox extends StatelessWidget {
  final Function(String foldername) onCreateFolder;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController folderNameController;

  CustomNewFolderDialogBox({
    @required this.onCreateFolder,
    // @required this.formKey,
    @required this.folderNameController,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      // elevation: 0,
      // backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Text(
              'New Folder',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: new BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                controller: folderNameController,
                validator: (value) =>
                    value.isEmpty ? "Folder name can't be empty" : null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Folder name',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            AppButtons.getButton(
              label: 'CREATE',
              context: context,
              onTap: () {
                if (formKey.currentState.validate()) {
                  onCreateFolder(folderNameController.text);
                  Navigator.pop(context);
                }
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    ));
  }
}
