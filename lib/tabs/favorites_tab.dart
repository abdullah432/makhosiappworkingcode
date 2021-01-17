import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/models/FavoritesModel.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:rating_bar/rating_bar.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<FavoritesModel> _dataList = [];
  bool _isLoading = true;
  StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = _getData().listen((querySnapshot) {
      _dataList.clear();
      querySnapshot.docs.forEach((snapshot) {
        var favoritesModel = FavoritesModel();
        favoritesModel.healerUid = snapshot.get(AppKeys.PRACTITIONER_UID);
        _dataList.add(favoritesModel);
      });
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Stream<QuerySnapshot> _getData() {
    return FirebaseFirestore.instance
        .collection('favorites')
        .document(FirebaseAuth.instance.currentUser.uid)
        .collection('my_favorites')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
        : _dataList.isEmpty
            ? AppStatusComponents.errorBody(message: 'No favorites found')
            : _getBody();
  }

  Widget _getBody() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: _dataList.map((model) => _getRow(model)).toList(),
    );
  }

  Widget _getRow(FavoritesModel model) {
    if (model.snapshot == null) {
      _fetchPractitionerData(_dataList.indexOf(model));
    }

    return model.snapshot != null
        ? GestureDetector(
            onTap: () {
              NavigationController.push(
                context,
                PractitionersProfileScreen(true, model.snapshot),
              );
            },
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(top: 8),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: model.snapshot.get(AppKeys.PROFILE_IMAGE) == null
                            ? Image.asset(
                                'images/profile_background.png',
                                width:
                                    ScreenDimensions.getScreenWidth(context) /
                                        3,
                              )
                            : Image.network(
                                model.snapshot.get(AppKeys.PROFILE_IMAGE),
                                width:
                                    ScreenDimensions.getScreenWidth(context) /
                                        3,
                                height:
                                    ScreenDimensions.getScreenWidth(context) /
                                        3,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${model.snapshot.get(AppKeys.FIRST_NAME)} ${model.snapshot.get(AppKeys.LAST_NAME)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Others.getSizedBox(boxHeight: 2, boxWidth: 0),
                            Row(
                              children: [
                                _getRattingBar(),
                                Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                                Text(
                                  '(4.5)',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Others.getSizedBox(boxHeight: 4, boxWidth: 0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black45,
                                ),
                                Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                                Expanded(
                                  child: Text(
                                    model.snapshot
                                        .get(AppKeys.PRACTICE_LOCATION),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Future<void> _fetchPractitionerData(int index) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(_dataList[index].healerUid)
        .get();
    _dataList[index].snapshot = snapshot;
    setState(() {});
  }

  Widget _getRattingBar() {
    return RatingBar.readOnly(
      initialRating: 4.5,
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      emptyColor: Colors.orange,
      filledColor: Colors.orange,
      halfFilledIcon: Icons.star_half,
      isHalfAllowed: true,
      halfFilledColor: Colors.orange,
      maxRating: 5,
      size: 18,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
