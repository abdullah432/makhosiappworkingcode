import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makhosi_app/main_ui/patients_ui/all_practitioners_screen.dart';
//import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard2.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:makhosi_app/tabs/announcements.dart';
import 'package:makhosi_app/tabs/nearby_practitioners_tab.dart';
import 'package:makhosi_app/tabs/recentprofiles.dart';
import 'package:makhosi_app/main_ui/general_ui/settingpage2.dart';
import 'package:makhosi_app/tabs/providers.dart';
import 'package:makhosi_app/tabs/Home_near.dart';

class AllTab extends StatefulWidget {
  dynamic _snapshot;
  AllTab(this._snapshot);
  @override
  _AllTabState createState() => _AllTabState(this._snapshot);
}

class _AllTabState extends State<AllTab> {
  List<dynamic> _dataList = [];
  bool _isLoading = true;
  dynamic _snapshot;

  _AllTabState(this._snapshot);
  @override
  void initState() {
    _dataList = new List();
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .limit(10)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((data) {
        _dataList.add({'id': data.id, ...data.data()});
      });
    });

    _isLoading = false;
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
        : _dataList.isEmpty
            ? AppStatusComponents.errorBody(message: 'No practitioner found')
            : _getBody();
  }

  Widget _getBody() {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.2,
              title: Container(
                height: 60,
                width: 250,
                //margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: new Theme(
                  data: new ThemeData(
                    hintColor: Colors.grey,
                    primaryColor: AppColors.COLOR_PRIMARY,
                    primaryColorDark: AppColors.COLOR_PRIMARY,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 10, top: 10, bottom: 10, left: 2),
                    child: TextField(
                      style: TextStyle(color: Colors.grey),
                      //controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.COLOR_PRIMARY,
                          ),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.COLOR_PRIMARY),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.COLOR_PRIMARY, width: 0.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    NavigationController.push(
                      context,
                      SettingPage(),
                    );
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('images/circleavater.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Color(
                          0xff6043f5,
                        ),
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                indicator: BubbleTabIndicator(
                  indicatorHeight: 25.0,
                  indicatorColor: AppColors.COLOR_PRIMARY,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text('Home'),
                  ),
                  Tab(
                    child: Text('Nearby Businesses'),
                  ),
                  Tab(
                    child: Text('Appointments'),
                  ),
                ],
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _getdataa(),
                  NearbyPractitionersTab(),
                  Text('shbsd')
                  // Consultations(),
                  //PractitionerBookingsScreen(),
                ],
              ),
            )));
  }

  Widget _getdataa() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        primary: true,
        children: [
          Text(
            "Mkhosi Knowledge Hub",
            style: TextStyle(
              color: Color(
                0xffb36647,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: new Container(
              height: 170.0,
              child: new Carousel(
                boxFit: BoxFit.cover,
                images: [
                  AssetImage('images/anouncement.png'),
                  AssetImage('images/splash_app_logo.png'),
                  AssetImage('images/anouncement.png'),
                ],
                autoplay: true,
                dotSize: 4.0,
                //dotColor: ,
                indicatorBgPadding: 2.0,
                dotBgColor: Colors.transparent,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Favourite Service Providers",
                style: TextStyle(
                  color: Color(
                    0xffb36647,
                  ),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                width: 76,
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Color(
                    0xff929292,
                  ),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),

          FrequentProducts(),

          Text(
            "Popular Businesses Near You",
            style: TextStyle(
              color: Color(
                0xffb36647,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          NearbyPractitionersTab2(),
          SizedBox(
            height: 5,
          ),

          Text(
            "Recently Visited Profiles",
            style: TextStyle(
              color: Color(
                0xffb36647,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(
              height: 160,
              width: 150,
              child: GridView.builder(
                // itemCount: mydata.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(1.0),
                primary: false,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.1,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _getrecent(_dataList[index]),
                itemCount: _dataList.length,
              )),
          Text(
            "Popular Service Providers",
            style: TextStyle(
              color: Color(
                0xffb36647,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          //providers(),
          SizedBox(
              height: 190,
              width: 150,
              child: GridView.builder(
                // itemCount: mydata.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(1.0),
                primary: false,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.1,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _getRow(_dataList[index]),
                itemCount: _dataList.length,
              )),

          // getBody(),
          //MyStatelessWidget(),
          /*SizedBox( // Horizontal ListView
            height: 120,
            child: ListView.builder(

              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  //alignment: Alignment.center,
                  color: Colors.blue[(index % 9) * 100],
                  child: Image.asset('images/enter.png', height: 120,width:150,),
                );
              },
            ),
          ),*/
        ],
      ),
    );
  }

  /* Widget getBody() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
          scrollDirection: Axis.horizontal,
              children: _dataList.map((snapshot) => _getRow(snapshot)).toList(),
            ),
          ),
        ],
      ),
    );
  }*/
  Widget _getrecent(dynamic snapshot) {
    String firstName = " ";
    String secondName = " ";
    String location = " ";
    String years = " ";
    String language = " ";
    String service = " ";
    dynamic instagram = " ";
    dynamic linkedin = " ";
    dynamic fb = " ";
    dynamic whatsapp = " ";
    String image = ' ';

    firstName = snapshot['prefered_buisness_name'];
    secondName = snapshot[AppKeys.SECOND_NAME];
    location = snapshot[AppKeys.ADDRESS];
    years = snapshot[AppKeys.PRACTICE_YEARS];
    language = snapshot[AppKeys.LANGUAGES];
    service = snapshot[AppKeys.SERVICE_TYPE];
    instagram = snapshot['social_medias_list'];
    linkedin = snapshot['LinkedInList'];
    fb = snapshot['FbList'];
    whatsapp = snapshot['WhatsappList'];
    image = snapshot['id_picture'];

    if (firstName == null) {
      firstName = " ";
    }

    if (secondName == null) {
      secondName = " ";
    }

    if (location == null) {
      location = " ";
    }

    return GestureDetector(
        onTap: () {
          NavigationController.push(
            context,
            BusinessCard2(snapshot['id'], firstName, location, years, language,
                service, instagram, linkedin, fb, whatsapp),
          );
        },
        child: Container(
          height: 250,
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 5),
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 1.5,
            child: Column(
              children: <Widget>[
                image != null
                    ? Image.network(
                        '${image}',
                        //width: 123,
                        //height: 80,
                        alignment: Alignment.center,
                        height: 90,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/circleavater.png',
                        alignment: Alignment.center,
                        height: 90,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                Expanded(
                  child: Text(
                    '${firstName} ${secondName}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _getRow(dynamic snapshot) {
    String firstName = " ";
    String secondName = " ";
    String location = " ";
    String years = " ";
    String language = " ";
    String service = " ";
    dynamic instagram = " ";
    dynamic linkedin = " ";
    dynamic fb = " ";
    dynamic whatsapp = " ";
    String image = ' ';

    firstName = snapshot['prefered_buisness_name'];
    secondName = snapshot[AppKeys.SECOND_NAME];
    location = snapshot[AppKeys.ADDRESS];
    years = snapshot[AppKeys.PRACTICE_YEARS];
    language = snapshot[AppKeys.LANGUAGES];
    service = snapshot[AppKeys.SERVICE_TYPE];
    instagram = snapshot['social_medias_list'];
    linkedin = snapshot['LinkedInList'];
    fb = snapshot['FbList'];
    whatsapp = snapshot['WhatsappList'];
    image = snapshot['id_picture'];

    if (firstName == null) {
      firstName = " ";
    }

    if (secondName == null) {
      secondName = " ";
    }

    if (location == null) {
      location = " ";
    }

    return GestureDetector(
        onTap: () {
          NavigationController.push(
            context,
            BusinessCard2(snapshot['id'], firstName, location, years, language,
                service, instagram, linkedin, fb, whatsapp),
          );
        },
        child: Container(
          height: 250,
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 5),
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 1.5,
            child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: image != null
                        ? Image.network(
                            '${image}',
                            //width: 123,
                            //height: 80,
                            alignment: Alignment.center,
                            height: 90,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/circleavater.png',
                            alignment: Alignment.center,
                            height: 90,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                Expanded(
                  child: Text(
                    '${firstName}${secondName}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '${location}',
                    style: TextStyle(fontSize: 8, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
    /*return GestureDetector(
      onTap: () {
        NavigationController.push(context, BusinessCard2(firstName, location, years, language, service, instagram, linkedin,fb, whatsapp),);
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
                          height: ScreenDimensions.getScreenWidth(context) / 3,
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
                              location,
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
    );*/
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
}
