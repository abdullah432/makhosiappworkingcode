import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/main_ui/blog_screens/add_new_post_screen.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class BLogHomeScreen extends StatefulWidget {
  String _practitionerUid;
  bool _isViewer;

  BLogHomeScreen(this._practitionerUid, this._isViewer);

  @override
  _BLogHomeScreenState createState() => _BLogHomeScreenState();
}

class _BLogHomeScreenState extends State<BLogHomeScreen> {
  StreamSubscription _subscription;
  bool _isLoading = true;
  List<DocumentSnapshot> _list = [];

  @override
  void initState() {
    _subscription = _getPostStream().listen((querySnapshot) {
      _list.clear();
      querySnapshot.docs.forEach((snapshot) {
        _list.add(snapshot);
      });
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbars.toolbar(
        context: context,
        title: 'Blog Posts',
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
      floatingActionButton: widget._isViewer
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.COLOR_PRIMARY,
              onPressed: () {
                NavigationController.push(context, AddNewPostScreen());
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
    );
  }

  Widget _getBody() {
    return _list.isEmpty && _isLoading
        ? Container()
        : !_isLoading && _list.isEmpty
            ? AppStatusComponents.errorBody(message: 'No post')
            : ListView.builder(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 80,
                ),
                itemCount: _list.length,
                itemBuilder: (context, position) => _rowDesign(position),
              );
  }

  Widget _rowDesign(position) {
    DocumentSnapshot object = _list[position];
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    object.get('image_url'),
                    height: 200,
                    width: ScreenDimensions.getScreenWidth(context),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    object.get('description'),
                  ),
                ],
              ),
            ),
          ),
        ),
        !widget._isViewer
            ? Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('blog_posts')
                        .doc(_list[position].id)
                        .delete();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    margin: EdgeInsets.all(16),
                    color: Colors.black38,
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Stream<QuerySnapshot> _getPostStream() {
    return FirebaseFirestore.instance
        .collection('blog_posts')
        .where('post_by_uid', isEqualTo: widget._practitionerUid)
        .snapshots();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
