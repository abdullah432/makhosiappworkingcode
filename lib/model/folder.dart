import 'package:cloud_firestore/cloud_firestore.dart';

class Folders {
  String _foldername;
  int _foldersize;
  List<String> _listOfFilesUrl;
  DocumentReference reference;

  Folders(this._foldername, this._foldersize, this._listOfFilesUrl);

  Map<String, dynamic> toMap() {
    return {
      'foldername': _foldername,
      'foldersize': _foldersize,
      'listoffilesurls': _listOfFilesUrl,
    };
  }

  Folders.fromMap(Map<String, dynamic> map, {this.reference})
      : _foldername = map['foldername'],
        _foldersize = map['foldersize'],
        _listOfFilesUrl = map['listoffilesurls'] != null
            ? List.from(map['listoffilesurls'])
            : [];

  Folders.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  //getters
  String get foldername => _foldername;
  int get foldersize => _foldersize;
  List<String> get listOfFilesUrl => _listOfFilesUrl;
  //setters
  set foldersize(int value) => _foldersize = value;
}
