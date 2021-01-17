import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/contracts/i_text_changed_listener.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/ui_components/app_text_fields.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:rating_bar/rating_bar.dart';

class AllPractitionersScreen extends StatefulWidget {
  @override
  _AllPractitionersScreenState createState() => _AllPractitionersScreenState();
}

class _AllPractitionersScreenState extends State<AllPractitionersScreen>
    implements ITextChangedListener {
  List<dynamic> _dataList =null;
  List<dynamic> _filteredList = [];
  bool _isLoading = true;

  @override
  void initState() {
    _dataList=new List();
    _getData();
    super.initState();
  }

  Future<void> _getData() async {

    await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .limit(20)
        .get().then((QuerySnapshot querySnapshot)
    {
      querySnapshot.docs.forEach((data)
      {
        _dataList.add(data.data());
      });
    }
    );

    _isLoading=false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : _dataList.isEmpty
              ? AppStatusComponents.errorBody(message: 'No practitioner found')
              : _getBody(),
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Others.getSizedBox(boxHeight: 32, boxWidth: 0),
          AppTextFields.getSearchTextField(
            controller: null,
            hint: 'Search practitioner',
            textListener: this,
            iTrailingClicked: null,
          ),
          Expanded(
            child: ListView(
                children: _dataList.map((snapshot) => _getRow(snapshot)).toList()
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRow(DocumentSnapshot snapshot) {
    String firstName=" ";
    String secondName=" ";
    String location= " ";

    firstName=snapshot[AppKeys.FIRST_NAME];
    secondName=snapshot[AppKeys.SECOND_NAME];
    location=snapshot[AppKeys.PRACTICE_LOCATION];

    if(firstName==null){firstName=" ";};
    if(secondName==null){secondName=" ";};
    if(location==null){location=" ";};
    return GestureDetector(
      onTap: () {
        NavigationController.push(
          context,
          PractitionersProfileScreen(true, snapshot),
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
                  child: snapshot[(AppKeys.PROFILE_IMAGE)] == null
                      ? Image.asset(
                          'images/profile_background.png',
                          width: ScreenDimensions.getScreenWidth(context) / 3,
                        )
                      : Image.network(
                    snapshot[(AppKeys.PROFILE_IMAGE)],
                          width: ScreenDimensions.getScreenWidth(context) / 3,
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
                              '${firstName} ${secondName}',
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
                              snapshot.get(AppKeys.PRACTICE_LOCATION),
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
    );
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
  void onTextChanged(String value) {
    _filteredList.clear();
    _dataList.forEach((snapshot) {
      if ('${snapshot.get(AppKeys.FIRST_NAME)}${snapshot.get(AppKeys.SECOND_NAME)}'
          .toLowerCase()
          .contains(value.toLowerCase())) {
        _filteredList.add(snapshot);
      }
    });
    setState(() {});
  }
}
