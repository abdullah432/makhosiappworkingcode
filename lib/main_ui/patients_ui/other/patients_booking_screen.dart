import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/patients_booking_screen_2.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/screen_dimensions.dart';

class PatientsBookingScreen extends StatefulWidget {
  final DocumentSnapshot _snapshot;

  PatientsBookingScreen(this._snapshot);

  @override
  _PatientsBookingScreenState createState() => _PatientsBookingScreenState();
}

class _PatientsBookingScreenState extends State<PatientsBookingScreen>
    implements IRoundedButtonClicked {
  Map<String, dynamic> _timingMap;
  String _selectedDate, _day, _selectionDescriptionLabel = '';
  int _selectedHour;
  List<DocumentSnapshot> _bookingList = [];
  bool _isLoading = true;
  List<DocumentSnapshot> _dayBookingsList = [];
  bool _forSomeoneElse = false;
  var _emailEditController = TextEditingController();
  var _mobileEditController = TextEditingController();
  Map snap;

  @override
  void initState() {
    snap = widget._snapshot.data();
    _timingMap = widget._snapshot.get(AppKeys.TIMINGS);
    _emailEditController.text = widget._snapshot.get(AppKeys.EMAIL);
    _getBookings();
    super.initState();
  }

  Future<void> _getBookings() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('appointment_to', isEqualTo: widget._snapshot.id)
          .get();
      snapshot.docs.forEach((booking) {
        _bookingList.add(booking);
      });
      setState(() {
        _isLoading = false;
      });
    } catch (exc) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var snap = widget._snapshot.data();
    return Scaffold(
      body: _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : CustomScrollView(slivers: [
              SliverAppBar(
                  expandedHeight: 150.0,
                  backgroundColor: Colors.transparent,
                  floating: false,
                  snap: false,
                  pinned: false,
                  centerTitle: true,
                  title: Text(
                    'BOOKING',
                    style: TextStyle(
                        color: AppColors.COLOR_DARKGREY,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  flexibleSpace: ListView(
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Consultation Fees',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ZAR/session*',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snap.containsKey('consultation_fee')
                                  ? '${snap['consultation_fee']}'
                                  : '0',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.COLOR_ORG,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                        child: Text(
                          '*Note: Session fees are for consultations only and do not'
                          'include orders,  and other requests',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: <Widget>[]),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height + 26,
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getPractitionerDetailsSection(),
                      _getDatePickerButton(),
                      Others.getSizedBox(boxHeight: 12, boxWidth: 0),
                      _getTimeSelectionSection(),
                      Others.getSizedBox(boxHeight: 32, boxWidth: 0),
                      Row(
                        children: [
                          _getLabelText('Email Address'),
                          Checkbox(
                              value: _forSomeoneElse,
                              onChanged: (val) {
                                setState(() {
                                  _forSomeoneElse = val;
                                });
                              }),
                          _getLabelText('For someone else'),
                        ],
                      ),
                      TextField(
                        enabled: _forSomeoneElse,
                        controller: _emailEditController,
                        decoration: InputDecoration(
                          enabled: _forSomeoneElse,
                          fillColor: !_forSomeoneElse
                              ? Colors.grey[100]
                              : Colors.transparent,
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Visibility(
                        visible: _forSomeoneElse,
                        child: _getLabelText('Phone Number'),
                      ),
                      Visibility(
                        visible: _forSomeoneElse,
                        child: TextField(
                          controller: _mobileEditController,
                          keyboardType: TextInputType.phone,
                          maxLength: 12,
                          decoration: InputDecoration(
                              enabled: _forSomeoneElse,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Others.getSizedBox(boxHeight: 17, boxWidth: 0),
                      _getLabelText('Appointment Date & Time'),
                      _getResultLabel(),
                      Others.getSizedBox(boxHeight: 24, boxWidth: 0),
                      AppButtons.getRoundedButton(
                        context: context,
                        iRoundedButtonClicked: this,
                        label: 'Confirm Booking',
                        clickType: ClickType.DUMMY,
                      )
                    ],
                  ),
                );
              }, childCount: 1))
            ]),
    );
  }

  Widget _getLabelBody(label) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      color: Colors.black12,
      width: ScreenDimensions.getScreenWidth(context),
      padding: EdgeInsets.all(8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _getLabelText(label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 17,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getResultLabel() {
    return Visibility(
      visible: (_selectionDescriptionLabel.isNotEmpty &&
          _selectionDescriptionLabel != null),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _selectionDescriptionLabel,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColors.COLOR_PRIMARY,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTimeSelectionSection() {
    List<int> timingList = _getTimingHoursList();
    List<int> bookedHours = [];
    if (timingList.isNotEmpty) {
      timingList.removeAt(timingList.length - 1);
      timingList.removeAt(timingList.length - 1);

      //availability check
      if (_dayBookingsList.isNotEmpty) {
        for (var booking in _dayBookingsList) {
          bookedHours.add(booking.get('appointment_start_hour'));
          bookedHours.add(booking.get('appointment_start_hour') + 1);
          bookedHours.add(booking.get('appointment_start_hour') - 1);
        }
      }
    }
    return timingList.isNotEmpty
        ? Wrap(
            children: timingList.map(
              (hour) {
                bool isAvailable = true;
                if (bookedHours.isNotEmpty) {
                  for (var i in bookedHours) {
                    if (i == hour) {
                      isAvailable = false;
                      break;
                    }
                  }
                }
                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                          if (_selectedHour != hour) {
                            _selectedHour = hour;
                            _selectionDescriptionLabel =
                                '$_selectedDate at ${_selectedHour <= 12 ? '$_selectedHour AM' : '${_selectedHour - 12} PM'} ';
                          } else {
                            _selectedHour = null;
                            _selectionDescriptionLabel = '';
                          }
                          setState(() {});
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(right: 12, top: 12),
                    width: ScreenDimensions.getScreenWidth(context) / 5.1,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? _selectedHour == hour
                              ? AppColors.COLOR_PRIMARY
                              : Colors.transparent
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isAvailable
                            ? _selectedHour == hour
                                ? Colors.transparent
                                : AppColors.COLOR_PRIMARY
                            : Colors.black54,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      hour <= 12 ? '$hour AM' : '${hour - 12} PM',
                      style: TextStyle(
                        fontSize: 13,
                        color: isAvailable
                            ? _selectedHour == hour
                                ? Colors.white
                                : AppColors.COLOR_PRIMARY
                            : Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          )
        : Container(
            height: 150,
            width: ScreenDimensions.getScreenWidth(context),
            child: AppStatusComponents.errorBody(message: 'Select date.'),
          );
  }

  List<int> _getTimingHoursList() {
    try {
      List<int> hoursList = [];
      int openHour = int.parse(_timingMap['${_day?.toLowerCase()}_open']);
      int closeHour = int.parse(_timingMap['${_day?.toLowerCase()}_close']);
      if (openHour == 0 && closeHour == 0) {
        return [];
      } else {
        for (int i = openHour; i <= closeHour; i++) {
          hoursList.add(i);
        }
        return hoursList;
      }
    } catch (exc) {
      return [];
    }
  }

  Widget _getDatePickerButton() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Available Time',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(days: 90),
              ),
            );
            if (selectedDate != null) {
              _getDayName(selectedDate.weekday);
              _selectedDate =
                  '${selectedDate.day < 10 ? '0${selectedDate.day}' : selectedDate.day}/${selectedDate.month < 10 ? '0${selectedDate.month}' : selectedDate.month}/${selectedDate.year}';
              _dayBookingsList.clear();
              _bookingList.forEach((booking) {
                if (booking.get('appointment_date') == _selectedDate) {
                  _dayBookingsList.add(booking);
                }
              });
              setState(() {
                _selectedHour = null;
                _selectionDescriptionLabel = '';
              });
            }
          },
          child: Container(
            height: 40,
            color: AppColors.COLOR_PRIMARY,
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
                Others.getSizedBox(boxHeight: 0, boxWidth: 8),
                Text(
                  _selectedDate == null ? 'Select Date' : '$_selectedDate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _getDayName(int day) {
    switch (day) {
      case 1:
        {
          _day = 'Monday';
          break;
        }
      case 2:
        {
          _day = 'Tuesday';
          break;
        }
      case 3:
        {
          _day = 'Wednesday';
          break;
        }
      case 4:
        {
          _day = 'Thursday';
          break;
        }
      case 5:
        {
          _day = 'Friday';
          break;
        }
      case 6:
        {
          _day = 'Saturday';
          break;
        }
      case 7:
        {
          _day = 'Sunday';
          break;
        }
    }
  }

  Widget _getPractitionerDetailsSection() {
    bool isOnline = widget._snapshot.get(AppKeys.ONLINE);

    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      width: ScreenDimensions.getScreenWidth(context),
      child: Row(
        children: [
          widget._snapshot.get("id_picture") != null
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    widget._snapshot.get("id_picture"),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 45,
                    ),
                  ),
                ),
          Others.getSizedBox(boxHeight: 0, boxWidth: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget._snapshot.get(AppKeys.FIRST_NAME)} ${snap.containsKey(AppKeys.SECOND_NAME) ? widget._snapshot.get(AppKeys.SECOND_NAME) : ""}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.brightness_1,
                      color: isOnline ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    Others.getSizedBox(boxHeight: 0, boxWidth: 4),
                    Text(isOnline ? 'Online' : 'Offline'),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.subdirectory_arrow_left_rounded,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  @override
  onClick(ClickType clickType) {
    NavigationController.push(
      context,
      PatientBookingFinal(
        email: _emailEditController.text,
        mobile: _forSomeoneElse ? _mobileEditController.text : null,
        forSomeoneElse: _forSomeoneElse,
        date: _selectedDate,
        time: _selectedHour,
        selectionDescription: _selectionDescriptionLabel,
        consultationFee: 120,
        practitioner: widget._snapshot.id,
      ),
    );
  }
}
