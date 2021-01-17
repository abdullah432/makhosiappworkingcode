import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'file_picker_service.dart';

class FirebaseStorageService with ChangeNotifier {
  UPLOADSTATUS uploadstatus = UPLOADSTATUS.INITIAL;
  double progress = 0.0;
  int fileSize = 0;
  String downloadUrl;
  final FirebaseAuth auth = FirebaseAuth.instance;

  //upload file (either image or video to firestore)
  Future<String> uploadFileToStorage({
    @required File file,
    @required FilePickerService filePickerService,
  }) async {
    uploadstatus = UPLOADSTATUS.INPROGRESS;
    notifyListeners();
    // String path =
    //     FirestorePath.filePath(useruid, contentType, basename(file.path));
    String path = "users/${auth.currentUser.uid}/${basename(file.path)}";
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(
        file, StorageMetadata(contentType: 'image/png'));

    // await uploadTask.whenComplete(() => null);
    double bytetransfer;
    uploadTask.events.listen((event) {
      bytetransfer = event.snapshot.bytesTransferred.toDouble() /
          event.snapshot.totalByteCount.toDouble();
      progress = bytetransfer * 100;
      notifyListeners();
    });
    await uploadTask.onComplete;
    print('after done');
    StorageMetadata metadata = await storageReference.getMetadata();
    print('done');
    fileSize = metadata.sizeBytes;
    // Url used to download file/image
    downloadUrl = await storageReference.getDownloadURL();
    //complete (clear cache data)
    uploadstatus = UPLOADSTATUS.COMPLETE;
    progress = 0.0;
    filePickerService.clearFilePickItem();
    // notifyListeners(); //because clearFilePickItem is calling notifyListner
    return downloadUrl;
  }
}

enum UPLOADSTATUS {
  INITIAL,
  INPROGRESS,
  COMPLETE,
}
