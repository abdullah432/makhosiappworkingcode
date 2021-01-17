import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file_picker_service.dart';

Future<void> chooseFileFromGallery(BuildContext context,
    {FileType fileType: FileType.any}) async {
  try {
    final imagePicker = Provider.of<FilePickerService>(context, listen: false);
    imagePicker.pickFile(fileType: fileType);
  } catch (e) {
    print(e.toString());
  }
}
