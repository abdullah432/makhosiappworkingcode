import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/patients_ui/other/add_meeting.dart';
import 'package:makhosi_app/main_ui/patients_ui/profile_screens/patient_profile_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/view_consulation_event.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/weather_ui/weather_page.dart';
import 'package:makhosi_app/models/bookings_model.dart';
import 'package:makhosi_app/ui_components/app_status_components.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/holidays.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:table_calendar/table_calendar.dart';

class PractitionerBookingsScreen extends StatefulWidget {
  @override
  _PractitionerBookingsScreenState createState() =>
      _PractitionerBookingsScreenState();
}

class _PractitionerBookingsScreenState
    extends State<PractitionerBookingsScreen> {
  CalendarController _calendarController = CalendarController();
  List<DocumentSnapshot> _bookingsList = [];
  List<DocumentSnapshot> _eventsList = [];
  List<BookingsModel> _finalList = [];
  List<Map> _eventList = [];

  Map<DateTime, List<dynamic>> _holidays = Holidays.list;
  bool _isLoading = true;
  String _uid;
  int _currentYear, _currentMonth, _currentDay, _currentHour;
  Map<DateTime, List<dynamic>> _events = Map();
  bool _isBookingTabSelected = true;

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
        .where('appointment_to', isEqualTo: _uid)
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

    FirebaseFirestore.instance
        .collection('calendar_events')
        .where('event_created_by', isEqualTo: _uid)
        .get()
        .then((eventsSnapshot) {
      _eventsList = eventsSnapshot.docs.map((doc) => doc).toList();
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
          model.patientUid = i.get('appointment_by');
          _finalList.add(model);
        } else if (_currentMonth == bookingMonth && _currentDay == bookingDay) {
          if (_currentHour <= i.get('appointment_start_hour')) {
            BookingsModel model = BookingsModel();
            model.bookingSnapshot = i;
            model.patientUid = i.get('appointment_by');
            _finalList.add(model);
          }
        } else if (_currentMonth < bookingMonth) {
          BookingsModel model = BookingsModel();
          model.bookingSnapshot = i;
          model.patientUid = i.get('appointment_by');
          _finalList.add(model);
        }
      }
    }

    for (var event in _eventsList) {
      Timestamp eventsDate = event.get('event_timestamp');

      _events[eventsDate.toDate()] = [
        {
          'category': event.get('category'),
          'invites': event.get('invites'),
          'note': event.get('note')
        }
      ];

      if (eventsDate.millisecondsSinceEpoch >=
          DateTime.now().millisecondsSinceEpoch) {
        _eventList.add({
          'category': event.get('category'),
          'invites': event.get('invites'),
          'note': event.get('note')
        });
      }
    }
    _filterEvents();
    setState(() {
      _isLoading = false;
    });
  }

  void _filterEvents() {
    for (BookingsModel model in _finalList) {
      var eventList = [];
      String bookingDate = model.bookingSnapshot.get('appointment_date');
      DateTime eventKeyDateTime; //very IMPORTANT
      String bookingDayString = '',
          bookingMonthString = '',
          bookingYearString = '';
      int bookingDay, bookingMonth, bookingYear, slashCount = 0;
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
      eventKeyDateTime = DateTime.parse(
          '$bookingYearString-$bookingMonthString-$bookingDayString');
      if (_events.containsKey(eventKeyDateTime)) {
        continue;
      }
      for (BookingsModel i in _finalList) {
        if (i.bookingSnapshot.get('appointment_date') == bookingDate) {
          eventList.add(DateTime.now().millisecond.toString());
        }
      }
      if (eventList.isNotEmpty) {
        _events[eventKeyDateTime] = eventList;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? AppStatusComponents.loadingContainer(AppColors.COLOR_PRIMARY)
          : _finalList.isEmpty
          ? AppStatusComponents.errorBody(message: 'No appointments')
          : _getBody();
  }

  Widget _tabs() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: MediaQuery.of(context).size.width,
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
                  _isBookingTabSelected = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: _isBookingTabSelected
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.COLOR_PRIMARY,
                )
                    : null,
                child: Text(
                  'Bookings & Appoinments',
                  style: TextStyle(
                      color:
                      _isBookingTabSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBookingTabSelected = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: !_isBookingTabSelected
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.COLOR_PRIMARY,
                )
                    : null,
                child: Text(
                  'Weather Forecast',
                  style: TextStyle(
                      color:
                      !_isBookingTabSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBody() {
    return Container(
        color: Colors.white,
        child: _isBookingTabSelected
            ? Column(
          children: [
            _tabs(),
            TableCalendar(
              calendarController: _calendarController,
              events: _events,
              holidays: _holidays,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                holidayStyle: TextStyle().copyWith(color: Colors.red),
              ),
              onDaySelected: (day, x, e) {
                if (e.isNotEmpty) AppToast.showToast(message: e[0]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: AppColors.COLOR_PRIMARY,
                  onPressed: () {
                    NavigationController.push(
                      context,
                      AddCalanderEvent(
                        dateTime: _calendarController.selectedDay,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: _finalList
                    .map((booking) => _rowDesign(booking))
                    .toList()
                  ..addAll(_eventList.map<Widget>((e) =>
                      _rowEventsDesign(
                          e['category'], e['note'], e['invites']))),
              ),
            ),
          ],
        )
            : ListView(
          children: [
            _tabs(),
            WeatherPage(),
          ],
        ));
  }

  Widget _rowEventsDesign(String category, String note, String invites) {
    return GestureDetector(
      onTap: () {
        // if (model.profileSnapshot != null) {
        //   NavigationController.push(
        //     context,
        //     PatientProfileScreen(model.profileSnapshot, true),
        //   );
        // }
      },
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category == null ? '' : category,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Note: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: note != null ? note : '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
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

  Widget _rowDesign(BookingsModel model) {
    if (model.profileSnapshot == null) {
      _getPatientProfile(model);
    }
    return GestureDetector(
      onTap: () async {
        if (model.profileSnapshot != null) {
          var date = await model.bookingSnapshot.get('appointment_date');
          NavigationController.push(
            context,
            ViewConsultationEvent(
                bookingId: model.bookingSnapshot.documentID, date: date),
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
                                  : 'Appointment with ${model.profileSnapshot.get('full_name')}',
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

  Future<void> _getPatientProfile(BookingsModel model) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(model.patientUid)
          .get();
      model.profileSnapshot = snapshot;
      setState(() {});
    } catch (exc) {
      print(exc);
    }
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}