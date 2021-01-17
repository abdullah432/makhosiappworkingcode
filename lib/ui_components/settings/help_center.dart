import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/helpcenter_string_constant.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class HelpCenterPage extends StatefulWidget {
  HelpCenterPage({Key key}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    final double height10 = 10.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.0,
              ),
              Text(
                'Frequently Asked Questions (FAQ)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'General Questions – For all Users',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfGeneral
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //buisness user
              Text(
                'Business Users',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Account Setup',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfAccountSetup
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Calendar
              Text(
                'Calendar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfCalandar
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Appointment
              Text(
                'Appointments',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfAppointment
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Reminders
              Text(
                'Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfReminders
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Booking
              Text(
                'Bookings',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfBookings
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Client
              Text(
                'Clients',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfClients
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Services
              Text(
                'Services',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfServices
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Reports
              Text(
                'Reports',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfReports
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Marketing
              Text(
                'Marketing',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfMarketing
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Plans and billing
              Text(
                'Plans and billing',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfPlaning
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Security
              Text(
                'Security',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfSecurity
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              //For General Users/ Clients
              Text(
                'For General Users/ Clients',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: HelpCenterStringConstant.listOfGeneralUsers
                    .map((item) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.question,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(item.answer),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
