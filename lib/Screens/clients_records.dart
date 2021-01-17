import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';
import 'package:makhosi_app/Assets/custom_listtile.dart';
import 'package:makhosi_app/Screens/folderview.dart';
import 'package:makhosi_app/Screens/mypersonal_drive.dart';
import 'package:makhosi_app/model/folder.dart';
import 'package:makhosi_app/utils/app_dialogues.dart';
import 'package:makhosi_app/utils/file_picker_service.dart';
import 'package:makhosi_app/utils/firebasestorageservice.dart';
import 'package:makhosi_app/utils/firestore_service.dart';
import 'package:makhosi_app/utils/methods.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:provider/provider.dart';

class ClientRecords extends StatefulWidget {
  @override
  _ClientRecordsState createState() => _ClientRecordsState();
}

class _ClientRecordsState extends State<ClientRecords> {
  List<Folders> listOfFolders = [];
  FirestoreService database = FirestoreService();
  //
  // final formKey = GlobalKey<FormState>();
  final foldernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //load all folders data
    loadUserFoldersData();
  }

  @override
  void dispose() {
    foldernameController?.dispose();
    super.dispose();
  }

  loadUserFoldersData() async {
    listOfFolders = await database.fetchFoldersData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themecolor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage('images/ic_back.png')),
                GestureDetector(
                    onTap: () {
                      NavigationController.push(
                          context,
                          MyPersonalStorage(
                            totalUseStorageSize:
                                Methods.totalFoldersSizedInInt(listOfFolders),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('images/ic_popmenu.png')),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage('images/ic_folder.png')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Client Records",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "${Methods.getItemCount(listOfFolders)} items . ${Methods.totalFoldersSized(listOfFolders)}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),

                // Image(image: AssetImage('images/ic_search.png'), height: 50,),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 15.0),
          //   child: Text(
          //     "Last update 10 October 2020 .",
          //     style: TextStyle(
          //         fontSize: 11,
          //         fontWeight: FontWeight.normal,
          //         color: Colors.grey,
          //         fontFamily: 'Poppins'),
          //   ),
          // ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  height: 400,
                  width: 350,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      // padding: EdgeInsets.all(12),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 180.0),
                                child: Image(
                                    image: AssetImage('images/ic_filter.png')),
                              ),
                            ],
                          ),
                        ),
                        listOfFolders.length != 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listOfFolders.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      Provider.of<FilePickerService>(context,
                                              listen: false)
                                          .clearFilePickItem();

                                      await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return FolderViewPage(
                                          folder: listOfFolders[index],
                                        );
                                      }));

                                      setState(() {});
                                    },
                                    child: items12(
                                      title: listOfFolders[index].foldername,
                                      subtitle:
                                          '${listOfFolders[index].listOfFilesUrl.length} items, ${Methods.formatBytes(listOfFolders[index].foldersize)}',
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text('No record found'),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 15,
                  right: 15,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.accentcolor,
                    onPressed: () async {
                      AppDialogues.showNewFolderPopup(
                        context,
                        foldernameController,
                        onCreateFolder: (foldername) async {
                          final folder = Folders(foldername, 0, []);
                          await database.createFolder(folder);
                          setState(() {
                            listOfFolders.add(folder);
                            foldernameController.clear();
                          });
                        },
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
