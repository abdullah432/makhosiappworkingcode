import 'package:flutter/material.dart';
import 'package:makhosi_app/model/folder.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:makhosi_app/utils/file_picker_service.dart';
import 'package:makhosi_app/utils/firebasestorageservice.dart';
import 'package:makhosi_app/utils/firestore_service.dart';
import 'package:makhosi_app/utils/getfilefromgallery.dart';
import 'package:makhosi_app/widgets/photoview.dart';
import 'package:provider/provider.dart';

import 'local_widgets/mygridview.dart';

class FolderViewPage extends StatefulWidget {
  final Folders folder;
  FolderViewPage({
    @required this.folder,
    Key key,
  }) : super(key: key);

  @override
  _FolderViewPageState createState() => _FolderViewPageState();
}

class _FolderViewPageState extends State<FolderViewPage> {
  AnimateIconController _animateIconController;

  @override
  void initState() {
    _animateIconController = AnimateIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.folder.foldername,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: widget.folder.listOfFilesUrl.length != 0
          ? MyGridView(
              contentList: widget.folder.listOfFilesUrl,
              onPressed: (url) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ImageView(
                    imageUrl: url,
                  );
                }));
              },
            )
          : Center(
              child: Text('Empty'),
            ),
    );
  }

  floatingActionButton() {
    return Consumer<FilePickerService>(builder: (context, filepicker, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<FirebaseStorageService>(
            builder: (context, storage, child) {
              print(storage.uploadstatus.toString());
              // if (storage.uploadstatus == UPLOADSTATUS.COMPLETE) {
              //   print('url: ' + storage.downloadUrl);
              //   print('filesize: ' + storage.fileSize.toString());

              //   final database =
              //       Provider.of<FirestoreService>(context, listen: false);
              //   final folder = widget.folder;
              //   folder.listOfFilesUrl.add(storage.downloadUrl);
              //   folder.foldersize = storage.fileSize.toString();
              //   _animateIconController.animateToStart();

              //   setState(() {
              //     database.updateFolder(folder);
              //     storage.uploadstatus = UPLOADSTATUS.INITIAL;
              //     storage.fileSize = 0;
              //     storage.downloadUrl = null;
              //   });
              // }
              return Visibility(
                  visible: filepicker.pickedFile.file != null,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      if (storage.uploadstatus != UPLOADSTATUS.INPROGRESS) {
                        // String contentType =
                        //     lookupMimeType(filepicker.pickedFile.file.path);
                        String downloadUrl = await storage.uploadFileToStorage(
                          // useruid: user.reference.id,
                          // contentType: contentType,
                          file: filepicker.pickedFile.file,
                          filePickerService: filepicker,
                        );

                        print('url: ' + storage.downloadUrl);
                        print('filesize: ' + storage.fileSize.toString());

                        final database = Provider.of<FirestoreService>(context,
                            listen: false);
                        final folder = widget.folder;
                        folder.listOfFilesUrl.add(storage.downloadUrl);
                        folder.foldersize += storage.fileSize;
                        _animateIconController.animateToStart();

                        setState(() {
                          database.updateFolder(folder);
                          storage.uploadstatus = UPLOADSTATUS.INITIAL;
                          storage.fileSize = 0;
                          storage.downloadUrl = null;
                        });
                      }
                    },
                    child: storage.uploadstatus == UPLOADSTATUS.INPROGRESS
                        ? Text(
                            '${storage.progress.toStringAsFixed(0)} %',
                            style: TextStyle(fontFamily: 'Poppins'),
                          )
                        : Icon(
                            Icons.cloud_upload,
                            color: Colors.green,
                          ),
                  ));
            },
          ),
          SizedBox(height: 5.0),
          FloatingActionButton(
            backgroundColor: AppColors.COLOR_PRIMARY,
            onPressed: () {},
            child: AnimateIcons(
              controller: _animateIconController,
              startIcon: Icons.add,
              endIcon: Icons.close,
              size: 30.0,
              startTooltip: 'Add',
              endTooltip: 'Clear',
              onStartIconPress: () {
                print('start');
                chooseFileFromGallery(context);
                return true;
              },
              onEndIconPress: () {
                print('End');
                filepicker.clearFilePickItem();

                return true;
              },
              duration: Duration(milliseconds: 500),
              color: Colors.white,
              clockwise: false,
            ),
          ),
        ],
      );
    });
  }
}
