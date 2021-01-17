import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/models/bookings_model.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/utils/app_keys.dart';

class BookingsTab extends StatefulWidget {
  @override
  _BookingsTabState createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  List<DocumentSnapshot> _bookingsList = [];
  List<BookingsModel> _finalList = [];
  bool _isLoading = true;
  String _uid;
  int _currentYear, _currentMonth, _currentDay, _currentHour;

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    _currentYear = dateTime.year;
    _currentMonth = dateTime.month;
    _currentDay = dateTime.day;
    _currentHour = dateTime.hour;
    _uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('bookings')
        .where('appointment_by', isEqualTo: _uid)
        .get()
        .then((bookingsSnapshot) {
      bookingsSnapshot.docs.forEach((booking) {
        _bookingsList.add(booking);
      });
      _finaliseList();
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        AppToast.showToast(message: error.toString());
      });
    });
    super.initState();
  }

  void _finaliseList() {
    _finalList.clear();
    for (var i in _bookingsList) {
      String bookingDayString = '',
          bookingMonthString = '',
          bookingYearString = '';
      int bookingDay, bookingMonth, bookingYear, slashCount = 0;
      String bookingDate = i.get('appointment_date');
      //filtering day, month and year
      for (int i = 0; i < bookingDate.length; i++) {
        if (bookingDate[i] != '/') {
          if (slashCount == 0) {
            bookingDayString = '$bookingDayString${bookingDate[i]}';
          } else if (slashCount == 1) {
            bookingMonthString = '$bookingMonthString${bookingDate[i]}';
          } else {
            bookingYearString = '$bookingYearString${bookingDate[i]}';
          }
        } else {
          slashCount++;
        }
      }
      // At this stage, days, months and years are separately stored in strings, no let's convert them into integers for comparison
      bookingDay = int.parse(bookingDayString);
      bookingMonth = int.parse(bookingMonthString);
      bookingYear = int.parse(bookingYearString);
      // now we have converted days, months and years into integers, now let's compare them
      if (_currentMonth <= bookingMonth && _currentYear <= bookingYear) {
        if (_currentMonth == bookingMonth && _currentDay < bookingDay) {
          BookingsModel model = BookingsModel();
          model.bookingSnapshot = i;
          model.practitionerUid = i.get('appointment_to');
          _finalList.add(model);
        } else if (_currentMonth == bookingMonth && _currentDay == bookingDay) {
          if (_currentHour <= i.get('appointment_start_hour')) {
            BookingsModel model = BookingsModel();
            model.bookingSnapshot = i;
            model.practitionerUid = i.get('appointment_to');
            _finalList.add(model);
          }
        } else if (_currentMonth < bookingMonth) {
          BookingsModel model = BookingsModel();
          model.bookingSnapshot = i;
          model.practitionerUid = i.get('appointment_to');
          _finalList.add(model);
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
        : _finalList.isEmpty
            ? AppStatusComponents.errorBody(message: 'No appointments')
            : _getBody();
  }

  Widget _getBody() {
    return ListView(
      children: _finalList.map((booking) => _rowDesign(booking)).toList(),
    );
  }

  Widget _rowDesign(BookingsModel model) {
    if (model.profileSnapshot == null) {
      _getPractitionerProfile(model);
    }
    return GestureDetector(
      onTap: () {
        if (model.profileSnapshot != null) {
          NavigationController.push(
            context,
            PractitionersProfileScreen(true, model.profileSnapshot),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                model.profileSnapshot == null
                    ? Others.getProfilePlaceHOlder()
                    : model.profileSnapshot.get('profile_image') == null
                        ? Others.getProfilePlaceHOlder()
                        : CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              model.profileSnapshot.get('profile_image'),
                            ),
                          ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.profileSnapshot == null
                                  ? ''
                                  : 'Appointment with ${model.profileSnapshot.get('first_name')} ${model.profileSnapshot.get('last_name')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'On ${model.bookingSnapshot.get('appointment_date')}, at ${model.bookingSnapshot.get('appointment_start_hour') > 12 ? model.bookingSnapshot.get('appointment_start_hour') - 12 : model.bookingSnapshot.get('appointment_start_hour')} ${model.bookingSnapshot.get('appointment_start_hour') > 12 ? 'PM' : 'AM'}',
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

  Future<void> _getPractitionerProfile(BookingsModel model) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(AppKeys.PRACTITIONERS)
          .doc(model.practitionerUid)
          .get();
      model.profileSnapshot = snapshot;
      setState(() {});
    } catch (exc) {
      print(exc);
    }
  }
}
