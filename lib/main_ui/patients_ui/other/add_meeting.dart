import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/practitioner_bookings_screen.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/profile/practitioners_profile_screen.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';

class AddCalanderEvent extends StatefulWidget {
  final dateTime;
  AddCalanderEvent({this.dateTime});
  @override
  _AddCalanderEventState createState() => _AddCalanderEventState();
}

class _AddCalanderEventState extends State<AddCalanderEvent>
    implements IRoundedButtonClicked {
  TextEditingController _noteText = TextEditingController(text: '');
  TextEditingController _invitesText = TextEditingController(text: '');
  DateTime _dTime = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  List category = [
    TaskLabel(isSelected: false, text: 'Admin'),
    TaskLabel(isSelected: false, text: 'Orders'),
    TaskLabel(isSelected: false, text: 'Inventory'),
    TaskLabel(isSelected: false, text: 'Consultation'),
    TaskLabel(isSelected: false, text: 'Business Meeting'),
  ];

  Widget _getHeadingText(label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getCategoryTitle() {
    return Text(
      'Category',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getDate() {
    return InkWell(
      onTap: () async {
        var newDate = await showDatePicker(
            context: context,
            initialDate: _dTime,
            firstDate: _dTime,
            lastDate: DateTime.now().add(Duration(days: 90)));
        setState(() {
          _dTime = newDate;
        });
      },
      child: Text(
        DateFormat('EE d, MMMM, y').format(_dTime),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _getTime() {
    return InkWell(
      onTap: () async {
        var newTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        setState(() {
          _time = newTime;
        });
      },
      child: Text(
        _time.format(context),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _coloredButton({int index, Color color, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: category[index].isSelected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    category[index].text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Text(
                category[index].text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }

  Widget _textBoxNotes() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _noteText,
        decoration: InputDecoration(
          fillColor: AppColors.COLOR_LIGHTSKY,
          hintText: 'Notes',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _textBoxInvites() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _invitesText,
        decoration: InputDecoration(
          hintText: 'Invites',
          fillColor: AppColors.COLOR_LIGHTSKY,
          prefixIcon: Icon(Icons.contact_mail_outlined),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _getCategoryBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _coloredButton(
                index: 0,
                color: Color(0xFF49B583),
                onTap: () {
                  setState(() {
                    category.forEach((cat) => cat.isSelected = false);
                    category[0].isSelected = !category[0].isSelected;
                  });
                }),
            _coloredButton(
                index: 1,
                color: Color(0xFFFF4171),
                onTap: () {
                  setState(() {
                    category.forEach((cat) => cat.isSelected = false);
                    category[1].isSelected = !category[1].isSelected;
                  });
                }),
            _coloredButton(
                index: 2,
                color: Color(0xFFE85EC0),
                onTap: () {
                  setState(() {
                    category.forEach((cat) => cat.isSelected = false);
                    category[2].isSelected = !category[2].isSelected;
                  });
                })
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _coloredButton(
                index: 3,
                color: Color(0xFFFFBD69),
                onTap: () {
                  setState(() {
                    category.forEach((cat) => cat.isSelected = false);
                    category[3].isSelected = !category[3].isSelected;
                  });
                }),
            _coloredButton(
                index: 4,
                color: Color(0xFF7F86FF),
                onTap: () {
                  setState(() {
                    category.forEach((cat) => cat.isSelected = false);
                    category[4].isSelected = !category[4].isSelected;
                  });
                })
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _getHeadingText('Add a task/meeting'),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(
                bottom: 20,
                left: 35,
              ),
              child: _getCategoryTitle()),
          _getCategoryBody(),
          SizedBox(
            height: 20,
          ),
          _textBoxNotes(),
          SizedBox(
            height: 20,
          ),
          _textBoxInvites(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              _getIconBox(
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF7F86FF),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              _getDate(),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              _getIconBox(
                Icon(
                  Icons.timelapse_rounded,
                  color: Color(0xFFFFBD69),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              _getTime(),
              Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: AppButtons.getRoundedButton(
              context: context,
              iRoundedButtonClicked: this,
              label: 'Save Event',
              clickType: ClickType.DUMMY,
            ),
          )
        ],
      ),
    );
  }

  Widget _getIconBox(Icon icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 7,
            color: Colors.grey[100],
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icon,
    );
  }

  @override
  onClick(ClickType clickType) async {
    try {
      var selectedCat =
          category.where((element) => element.isSelected).toList();
      var data = {
        'invites': _invitesText.text,
        'note': _noteText.text,
        'category': selectedCat[0].text,
        'event_timestamp': DateTime(
            _dTime.year, _dTime.month, _dTime.day, _time.hour, _time.minute),
        'event_created_by': FirebaseAuth.instance.currentUser.uid,
      };
      await FirebaseFirestore.instance.collection('calendar_events').add(data);
      Navigator.pop(context);
      Navigator.pop(context);

      NavigationController.push(context, PractitionerBookingsScreen());

      AppToast.showToast(message: 'Event successfully added');
    } catch (exc) {
      AppToast.showToast(message: 'Something Went Wrong');
    }
  }
}

class TaskLabel {
  bool isSelected = false;
  String text = '';
  TaskLabel({this.isSelected, this.text});
}
