import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard2.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:rating_bar/rating_bar.dart';

class NearbyPractitionersTab2 extends StatefulWidget {
  @override
  _NearbyPractitionersTabState createState() => _NearbyPractitionersTabState();
}

class _NearbyPractitionersTabState extends State<NearbyPractitionersTab2> {
  List<dynamic> _practitioners = null;
  String _userCity, _mapStyle;
  bool _isLoading = true;
  static CameraPosition _initialCameraPosition;
  GoogleMapController _controller;
  Set<Marker> _markers = Set();
  var _customMarker;
  String _error;
  Color baseColor = Color(0xFFF2F2F2);
  @override
  void initState() {
    _practitioners = new List();
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    try {
      Location location = Location();
      PermissionStatus permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus == PermissionStatus.denied) {
          return;
        }
      }
      LocationData locationData = await location.getLocation();
      _initialCameraPosition = CameraPosition(
        target: LatLng(locationData.latitude, locationData.longitude),
        zoom: 10,
      );
      List<Address> addressList = await Geocoder.local
          .findAddressesFromCoordinates(
              Coordinates(locationData.latitude, locationData.longitude));
      if (addressList.isNotEmpty) {
        _userCity = addressList[0].subAdminArea;
        await _loadMapStyle();
        _getPractitioners();
      } else {
        await Future.delayed(
          Duration(seconds: 1),
        );
        _getLocation();
      }
    } catch (exc) {
      setState(() {
        _isLoading = false;
        _error = 'Error accessing your location, please try again later';
      });
    }
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.txt');
    _customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(32, 32),
        ),
        'images/location_marker.png');
  }

  Future<void> _getPractitioners() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(AppKeys.PRACTITIONERS)
          .where(AppKeys.PRACTICE_CITY, isEqualTo: _userCity)
          .get();
      if (snapshot.size == 0) {
        setState(() {
          _isLoading = false;
          AppToast.showToast(message: 'No practitioner found in your area');
        });
      } else {
        snapshot.docs.forEach((doc) {
          _practitioners.add({'id': doc.id, ...doc.data()});
          Marker marker = Marker(
            markerId: MarkerId(doc.id),
            icon: _customMarker,
            infoWindow: InfoWindow(
                title: '${doc[AppKeys.FIRST_NAME]} ${doc[AppKeys.LAST_NAME]}'),
            position: LatLng(
              doc[AppKeys.COORDINATES][AppKeys.LATITUDE],
              doc[AppKeys.COORDINATES][AppKeys.LONGITUDE],
            ),
          );
          _markers.add(marker);
        });
        setState(() {
          _isLoading = false;
        });
      }
    } catch (exc) {
      if (mounted)
        setState(() {
          _isLoading = false;
          AppToast.showToast(message: exc.toString());
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find A Service'),
      ),
      body: _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : _error != null
              ? AppStatusComponents.errorBody(message: _error)
              : _practitioners.isEmpty
                  ? AppStatusComponents.errorBody(
                      message: 'No practitioner in your area')
                  : _getBody(),
    );
  }

  Widget _getBody() {
    return Stack(
      children: [
        GoogleMap(
          markers: _markers,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            _controller.setMapStyle(_mapStyle);
          },
        ),
        _getPractitionersList(),
        _practitioners.isNotEmpty ? _getPractitionersCount() : Container(),
      ],
    );
  }

  Widget _getPractitionersCount() {
    return Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            Container(
              height: 135,
              width: 150,
              margin: EdgeInsets.only(left: 16, top: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('images/Oval.png'),
                          Others.getSizedBox(boxHeight: 0, boxWidth: 5),
                          Text(
                            'Traditional\n Healer',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _practitioners.length.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                          Text(
                            '${_practitioners.length == 1 ? 'Practitioner' : 'Practitioners'}\nFound',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Others.getSizedBox(boxHeight: 8, boxWidth: 0),
                      Text(
                        'Around You',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 135,
              width: 150,
              margin: EdgeInsets.only(left: 16, top: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('images/Oval.png'),
                          Others.getSizedBox(boxHeight: 0, boxWidth: 5),
                          Text(
                            'Mechanics',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _practitioners.length.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                          Text(
                            '${_practitioners.length == 1 ? 'Mechanic' : 'Mechanics'}\nFound',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Others.getSizedBox(boxHeight: 8, boxWidth: 0),
                      Text(
                        'Around You',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _getPractitionersList() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _practitioners.map((practitionerDoc) {
            return _getPractitionerRow(practitionerDoc);
          }).toList(),
        ),
      ),
    );
  }

  Widget _getPractitionerRow(dynamic snapshot) {
    bool isOnline = false;
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
    whatsapp = snapshot['WhatsappList'];

    firstName = snapshot['prefered_buisness_name'];
    secondName = snapshot[AppKeys.SECOND_NAME];
    location = snapshot[AppKeys.ADDRESS];
    years = snapshot[AppKeys.PRACTICE_YEARS];
    language = snapshot[AppKeys.LANGUAGES];
    service = snapshot[AppKeys.SERVICE_TYPE];
    instagram = snapshot[AppKeys.LIST_OF_SOCIAL_MEDIA];
    linkedin = snapshot['LinkedInList'];
    fb = snapshot['FbList'];
    if (firstName == null) {
      firstName = " ";
    }

    if (secondName == null) {
      secondName = " ";
    }

    if (location == null) {
      location = " ";
    }

    if (instagram == null) {
      instagram = " ";
    }

    if (snapshot[AppKeys.ONLINE] != null) {
      isOnline = snapshot[AppKeys.ONLINE];
    }
    String name =
        '${snapshot[AppKeys.FIRST_NAME]} ${snapshot[AppKeys.LAST_NAME]}';
    if (name.length > 30) {
      name = '${name.substring(0, 27)}...';
    }
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 12, bottom: 4),
      width: 290,
      margin: EdgeInsets.only(bottom: 32),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  snapshot[AppKeys.PROFILE_IMAGE] != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              NetworkImage(snapshot[AppKeys.PROFILE_IMAGE]),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            color: Colors.black12,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                  Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset('images/Object.png')
                ],
              ),
              Container(
                width: 190,
                height: 12,
                child: Row(
                  children: [
                    Others.getSizedBox(boxHeight: 0, boxWidth: 23),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Others.getSizedBox(boxHeight: 0, boxWidth: 40),
                  Icon(
                    Icons.brightness_1,
                    color: isOnline ? Colors.green : Colors.green,
                    size: 12,
                  ),
                  Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                  Text(
                    isOnline ? 'Available Now' : 'Available Now',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Others.getSizedBox(boxHeight: 0, boxWidth: 15),
                  _getRattingBar(),
                  Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                  Text(
                    '1000+ Reviews',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Others.getSizedBox(boxHeight: 10, boxWidth: 0),
              Row(
                children: [
                  Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                  ClayContainer(
                    color: baseColor,
                    height: 40,
                    width: 40,
                    borderRadius: 50,
                    child: GestureDetector(
                      onTap: () {
                        //TODO: take user to chat screen
                      },
                      child: Image.asset('images/phn.png'),
                    ),
                  ),
                  Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                  ClayContainer(
                    color: baseColor,
                    height: 40,
                    width: 40,
                    borderRadius: 50,
                    child: GestureDetector(
                      onTap: () {
                        //TODO: take user to chat screen
                      },
                      child: Image.asset('images/msg.png'),
                    ),
                  ),
                  Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                  SizedBox(
                    width: 100,
                    height: 25,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      color: AppColors.COLOR_PRIMARY,
                      onPressed: () {
                        NavigationController.push(
                          context,
                          BusinessCard2(
                              snapshot['id'],
                              firstName,
                              location,
                              years,
                              language,
                              service,
                              instagram,
                              linkedin,
                              fb,
                              whatsapp),
                        );
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //   Others.getSizedBox(boxHeight: 8, boxWidth: 0),
            ],
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
}
