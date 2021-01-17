import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewConsultationEvent extends StatefulWidget {
  final String bookingId, date;

  ViewConsultationEvent({this.bookingId, this.date});

  @override
  _ViewConsultationEventState createState() => _ViewConsultationEventState();
}

class _ViewConsultationEventState extends State<ViewConsultationEvent> {
  String _bookingTime = "";
  String _bookingDate = "";
  String _appointment_by = "";
  String _patientName = "";
  String _patientAddress = "";
  bool _isSickNote = false;
  bool _isQuotation = false;
  bool _isDetails = true;
  bool _isFiles = false;
  bool _isNotes = false;
  bool _isReadMe = false;

  @override
  void initState() {
    super.initState();
    _getBookingInfo();
  }

  Future<void> _getBookingInfo() async {
    var _bookingInfo = await FirebaseFirestore.instance
        .collection("bookings")
        // .where("appointment_by", isEqualTo: widget._patientUid)
        .doc(widget.bookingId)
        .get();
    setState(() {
      _bookingTime = _bookingInfo.get('appointment_start_hour').toString();
      _bookingDate = _bookingInfo.get('appointment_date').toString();
      _appointment_by = _bookingInfo.get('appointment_by').toString();
      _isSickNote = _bookingInfo.get('sicknote_required');
      _isQuotation = _bookingInfo.get('invoice_required');
    });
    var _patientInfo = await FirebaseFirestore.instance
        .collection("patients")
        .doc(_appointment_by)
        .get();
    setState(() {
      _patientName = _patientInfo.get('full_name').toString();
      _patientAddress = _patientInfo.get('address').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              expandedHeight: 200.0,
              backgroundColor: Color(0xff78BEBD),
              floating: false,
              snap: false,
              pinned: false,
              centerTitle: true,
              flexibleSpace: Container(
                child: ListView(
                  children: [
                    SizedBox(height: 80.0),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 30),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  // child: Text("data"),
                                  height: 60,
                                  width: 50,
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0)),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 50,
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                    color: AppColors.COLOR_PRIMARY,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0)),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 20,
                              left: 15,
                              child: Text(DateFormat('d/m/y')
                                  .parse(widget.date)
                                  .day
                                  .toString()),
                            ),
                            Positioned(
                              top: 65,
                              left: 7,
                              child: Text(
                                DateFormat('d/m/y')
                                    .parse(widget.date)
                                    .year
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),

                        // SizedBox(
                        //   width: 20,
                        // ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                          child: Text(
                            "Consultation with\n $_patientName",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                            // overflow: TextOverflow.clip,
                            // softWrap: false,
                            // maxLines: 1,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[]),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: MediaQuery.of(context).size.height + 30,
                    alignment: Alignment.bottomCenter,
                    color: AppColors.COLOR_PRIMARY,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Remind Me",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Mulish",
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: _isReadMe,
                          onChanged: (bool) {
                            setState(() {
                              _isReadMe = !_isReadMe;
                            });
                          },
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.white,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.white,
                          focusColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                        // border: Border.all(
                        //     color: Colors.black, // set border color
                        //     width: 0), // set border width
                        // borderRadius: BorderRadius.all(
                        //     Radius.circular(20.0)), // set rounded corner radius
                        // boxShadow: [
                        //   BoxShadow(
                        //     // blurRadius: 10,
                        //     color: Colors.white,
                        //     // offset: Offset(1, 3),
                        //   )
                        // ] // make rounded corner of border

                        ),
                    // height: MediaQuery.of(context).size.height + 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      // shrinkWrap: true,
                      children: [
                        _tabs(),
                        SizedBox(height: 10),
                        _isDetails ? _details() : Container(),
                        // Container(
                        //   height: 60,
                        //   color: AppColors.COLOR_PRIMARY,
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            }, childCount: 1),
          ),
          // SliverList(
          //   delegate:
          //       SliverChildBuilderDelegate((BuildContext context, int index) {
          //     return Container(
          //       padding: EdgeInsets.only(left: 20),
          //       // margin: EdgeInsets.only(left: 20),
          //       height: 60,
          //       color: AppColors.EDIT_PROFILE,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //       Container(
          //         child: Row(children: [
          //           Icon(
          //             Icons.notifications_active_outlined,
          //             color: Colors.white,
          //           ),
          //           SizedBox(width: 10),
          //           Text(
          //             "Remind Me",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 15,
          //               fontWeight: FontWeight.w700,
          //               fontFamily: "Mulish",
          //             ),
          //           ),
          //         ]),
          //       ),
          //       Switch(
          //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //         value: _isReadMe,
          //         onChanged: (bool) {
          //           setState(() {
          //             _isReadMe = !_isReadMe;
          //           });
          //         },
          //         inactiveThumbColor: Colors.white,
          //         inactiveTrackColor: Colors.white,
          //         activeColor: Colors.white,
          //         activeTrackColor: Colors.white,
          //         focusColor: Colors.white,
          //       ),
          //         ],
          //       ),
          //     );
          //   }, childCount: 1),
          // ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDetails = true;
                  _isFiles = false;
                  _isNotes = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: _isDetails
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.COLOR_PRIMARY,
                      )
                    : null,
                child: Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDetails = false;
                  _isFiles = true;
                  _isNotes = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: _isFiles
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.COLOR_PRIMARY,
                      )
                    : null,
                child: Center(
                  child: Text(
                    'Files',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isDetails = false;
                  _isFiles = false;
                  _isNotes = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: _isNotes
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.COLOR_PRIMARY,
                      )
                    : null,
                child: Center(
                  child: Text(
                    'Notes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _details() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "Client",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Mulish'),
            ),
          ),
          SizedBox(height: 10),
          // Image(image: null),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.schedule),
                SizedBox(width: 10),
                Text(
                  _bookingTime.toString(),
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Text(
                  _bookingDate,
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 10),
                Text(
                  "Lavaska centre",
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text(_patientAddress.toString(),
                style: TextStyle(
                  color: Color(0xFF8B8B8B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Mulish",
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.format_align_left),
                SizedBox(width: 10),
                Text(
                  "Consultation",
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, bottom: 10),
            child: Text(
              "Adminstration",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Checkbox(
                  value: _isQuotation,
                  onChanged: null,
                ),
                Text(
                  "Requested Quotation",
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Checkbox(value: _isSickNote, onChanged: null),
                Text(
                  "Requested Sick Note",
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Checkbox(value: true, onChanged: null),
                Text(
                  "Order  Request",
                  style: TextStyle(
                    fontFamily: "Mulish",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
