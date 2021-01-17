import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_trailing_clicked.dart';
import 'package:makhosi_app/models/ClosedDaysModel.dart';
import 'package:makhosi_app/models/DayTimeModel.dart';
import 'package:makhosi_app/models/TimingModel.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/app_toolbars.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:hexcolor/hexcolor.dart';

class EditHoursScreen extends StatefulWidget {
  EditHoursScreen({Key key}) : super(key: key);

  @override
  _EditHoursScreenState createState() => _EditHoursScreenState();
}

class _EditHoursScreenState extends State<EditHoursScreen>
    implements ITrailingClicked {
  var checkk = false;
  var checkk2 = false;
  DateTime now = DateTime.now();
  var _list = <DayTimeModel>[];
  var _closedDaysList = <ClosedDaysModel>[];
  var _sundayStartTimingController = TextEditingController();
  var _mondayStartTimingController = TextEditingController();
  var _tuesdayStartTimingController = TextEditingController();
  var _wednesdayStartTimingController = TextEditingController();
  var _thursdayStartTimingController = TextEditingController();
  var _fridayStartTimingController = TextEditingController();
  var _saturdayStartTimingController = TextEditingController();
  var _sundayEndTimingController = TextEditingController();
  var _mondayEndTimingController = TextEditingController();
  var _tuesdayEndTimingController = TextEditingController();
  var _wednesdayEndTimingController = TextEditingController();
  var _thursdayEndTimingController = TextEditingController();
  var _fridayEndTimingController = TextEditingController();
  var _saturdayEndTimingController = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < 7; i++) {
      var closingDay = ClosedDaysModel();
      closingDay.isOpen = true;
      closingDay.dayOfWeek = i;
      _closedDaysList.add(closingDay);
    }
    _sundayStartTimingController.text = '00:00';
    _mondayStartTimingController.text = '08:00';
    _tuesdayStartTimingController.text = '08:00';
    _wednesdayStartTimingController.text = '08:00';
    _thursdayStartTimingController.text = '08:00';
    _fridayStartTimingController.text = '08:00';
    _saturdayStartTimingController.text = '08:00';
    _sundayEndTimingController.text = '00:00';
    _mondayEndTimingController.text = '17:00';
    _tuesdayEndTimingController.text = '17:00';
    _wednesdayEndTimingController.text = '17:00';
    _thursdayEndTimingController.text = '17:00';
    _fridayEndTimingController.text = '17:00';
    _saturdayEndTimingController.text = '13:00';
    for (var i = 0; i < 7; i++) {
      var dayTimeModel = DayTimeModel();
      dayTimeModel.startHours = 0;
      dayTimeModel.endHours = 0;
      dayTimeModel.startMinutes = 0;
      dayTimeModel.endMinutes = 0;
      _list.add(dayTimeModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppToolbars.toolbarForResultScreen(
          title: 'Edit Hours',
          context: context,
          listener: this,
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Navigator.pop(context, null);
      },
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 2, top: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 160,
                width: 350,
                child: Image.asset(
                  "images/bgg.png",
                  width: 330,
                )),
            Center(
                child: Text(
                  'BUSINESS OPERATING HOURS',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black45,
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
                  'Configure availability by clicking on the day you are available and then followed by the times',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                )),
            SizedBox(
              height: 24,
            ),
            _getRow(
              0,
              'Sunday',
              _sundayStartTimingController,
              _sundayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              1,
              'Monday',
              _mondayStartTimingController,
              _mondayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              2,
              'Tuesday',
              _tuesdayStartTimingController,
              _tuesdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              3,
              'Wednesday',
              _wednesdayStartTimingController,
              _wednesdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              4,
              'Thursday',
              _thursdayStartTimingController,
              _thursdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              5,
              'Friday',
              _fridayStartTimingController,
              _fridayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            _getRow(
              6,
              'Saturday',
              _saturdayStartTimingController,
              _saturdayEndTimingController,
            ),
            SizedBox(
              height: 16,
            ),
            Center(
                child: Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                )),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checkk2 = !checkk2;
                    });
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: checkk2 ? Hexcolor('#78BEBD') : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                SizedBox(
                  width: 180,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checkk = !checkk;
                    });
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                            // color: checkk == true ? Colors.red : Colors.black,
                            color: Colors.black,
                          ),
                          color: checkk ? Hexcolor('#78BEBD') : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Available on Public\n Holidays',
                  style: TextStyle(color: Colors.black45, fontSize: 10),
                ),
                SizedBox(
                  width: 95,
                ),
                Text(
                  'Available for emergency\n consultations ',
                  style: TextStyle(color: Colors.black45, fontSize: 10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getRow(
      int index,
      String label,
      TextEditingController startTime,
      TextEditingController endTime,
      ) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            endTime.text == '11';
            setState(() {});
          },
          child: Container(
              height: 25,
              width: 90,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: startTime.text != '00' || endTime.text == '00'
                      ? Colors.white
                      : Hexcolor('#78BEBD'),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: startTime.text != '00' || endTime.text == '00'
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              )),
        ),
        SizedBox(
          width: 3,
        ),
        SizedBox(
          width: 11,
        ),
        GestureDetector(
          onTap: () async {
            TimeOfDay startTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
            );
            _list[index].startHours = startTimeOfDay.hour;
            _list[index].startMinutes = startTimeOfDay.minute;
            var hours, minutes;
            if (startTimeOfDay.hour < 10) {
              hours = '0${startTimeOfDay.hour}';
            } else {
              hours = startTimeOfDay.hour;
            }
            if (startTimeOfDay.minute < 10) {
              minutes = '0${startTimeOfDay.minute}';
            } else {
              minutes = startTimeOfDay.minute;
            }
            if (_list[index].startHours < _list[index].endHours) {
              AppToast.showToast(
                  message: 'Start time must be earlier than end time');
            } else {
              setState(() {
                startTime.text = '$hours:$minutes';
              });
            }
          },
          child: Others.timingBox(label: startTime.text),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.remove,
          color: Colors.black54,
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () async {
            TimeOfDay endTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: 00, minute: 00),
            );
            _list[index].endHours = endTimeOfDay.hour;
            _list[index].endMinutes = endTimeOfDay.minute;
            var hours, minutes;
            if (endTimeOfDay.hour < 10) {
              hours = '0${endTimeOfDay.hour}';
            } else {
              hours = endTimeOfDay.hour;
            }
            if (endTimeOfDay.minute < 10) {
              minutes = '0${endTimeOfDay.minute}';
            } else {
              minutes = endTimeOfDay.minute;
            }
            if (_list[index].startHours > _list[index].endHours) {
              AppToast.showToast(
                  message: 'End time cannot be earlier than start time');
            } else {
              setState(() {
                endTime.text = '$hours:$minutes';
              });
            }
          },
          child: Others.timingBox(label: endTime.text),
        ),
      ],
    );
  }

  @override
  void onTrailingClick() {
    String sundayStartTime = _sundayStartTimingController.text;
    String mondayStartTime = _mondayStartTimingController.text;
    String tuesdayStartTime = _tuesdayStartTimingController.text;
    String wednesdayStartTime = _wednesdayStartTimingController.text;
    String thursdayStartTime = _thursdayStartTimingController.text;
    String fridayStartTime = _fridayStartTimingController.text;
    String saturdayStartTime = _saturdayStartTimingController.text;

    String sundayEndTime = _sundayEndTimingController.text;
    String mondayEndTime = _mondayEndTimingController.text;
    String tuesdayEndTime = _tuesdayEndTimingController.text;
    String wednesdayEndTime = _wednesdayEndTimingController.text;
    String thursdayEndTime = _thursdayEndTimingController.text;
    String fridayEndTime = _fridayEndTimingController.text;
    String saturdayEndTime = _saturdayEndTimingController.text;

    if (sundayStartTime == '00' &&
        mondayStartTime == '00' &&
        tuesdayStartTime == '00' &&
        wednesdayStartTime == '00' &&
        thursdayStartTime == '00' &&
        fridayStartTime == '00' &&
        saturdayStartTime == '00' &&
        sundayEndTime == '00' &&
        mondayEndTime == '00' &&
        tuesdayEndTime == '00' &&
        wednesdayEndTime == '00' &&
        thursdayEndTime == '00' &&
        fridayEndTime == '00' &&
        saturdayEndTime == '00') {
      AppToast.showToast(message: 'You can\'t stay closed for all days');
    } else {
      TimingModel timingModel = TimingModel();

      if (sundayStartTime == '00' || sundayEndTime == '00') {
        timingModel.sundayStart = '00';
        timingModel.sundayEnd = '00';
      } else {
        timingModel.sundayStart = sundayStartTime;
        timingModel.sundayEnd = sundayEndTime;
      }

      if (mondayStartTime == '00' || mondayEndTime == '00') {
        timingModel.mondayStart = '00';
        timingModel.mondayEnd = '00';
      } else {
        timingModel.mondayStart = mondayStartTime;
        timingModel.mondayEnd = mondayEndTime;
      }

      if (tuesdayStartTime == '00' || tuesdayEndTime == '00') {
        timingModel.tuesdayStart = '00';
        timingModel.tuesdayEnd = '00';
      } else {
        timingModel.tuesdayStart = tuesdayStartTime;
        timingModel.tuesdayEnd = tuesdayEndTime;
      }

      if (wednesdayStartTime == '00' || wednesdayEndTime == '00') {
        timingModel.wednesdayStart = '00';
        timingModel.wednesdayEnd = '00';
      } else {
        timingModel.wednesdayStart = wednesdayStartTime;
        timingModel.wednesdayEnd = wednesdayEndTime;
      }

      if (thursdayStartTime == '00' || thursdayEndTime == '00') {
        timingModel.thursdayStart = '00';
        timingModel.thursdayEnd = '00';
      } else {
        timingModel.thursdayStart = thursdayStartTime;
        timingModel.thursdayEnd = thursdayEndTime;
      }

      if (fridayStartTime == '00' || fridayEndTime == '00') {
        timingModel.fridayStart = '00';
        timingModel.fridayEnd = '00';
      } else {
        timingModel.fridayStart = fridayStartTime;
        timingModel.fridayEnd = fridayEndTime;
      }

      if (saturdayStartTime == '00' || saturdayEndTime == '00') {
        timingModel.saturdayStart = '00';
        timingModel.saturdayEnd = '00';
      } else {
        timingModel.saturdayStart = saturdayStartTime;
        timingModel.saturdayEnd = saturdayEndTime;
      }
      Navigator.pop(context, timingModel);
    }
  }
}