import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Mkhosi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              //description
              Text(
                StringConstants.ABOUT_PAGE_INTRODUCTION,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20.0,
              ),
              //vissions statement
              Text(
                StringConstants.ABOUT_PAGE_VISION,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: height10,
              ),
              //heading 2 big
              Text(
                'Application Platforms',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
              ),
              SizedBox(
                height: height10,
              ),
              //platform statement
              Text(
                StringConstants.ABOUT_PAGE_PLATFORM,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              //heading 3
              Text(
                'Features of the Mkhosi App',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: height10,
              ),
              //platform statement
              Text(
                StringConstants.ABOUT_PAGE_FEATURES_TEXT,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.justify,
              ),
              //space
              SizedBox(
                height: height10,
              ),
              //heading 4
              Text(
                'Service Providers',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              //space
              SizedBox(
                height: height10,
              ),
              //SERVICE PROVIDER TEXT
              Text(
                StringConstants.ABOUT_PAGE_SERVICEPROVIDER_TEXT,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              //heading 4
              Text(
                'General Users',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              //space
              SizedBox(
                height: height10,
              ),
              //SERVICE PROVIDER TEXT
              Text(
                StringConstants.ABOUT_PAGE_GENERICUSER_TEXT,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'What sets Mkhosi Apart?',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18.0),
              ),
              //space
              SizedBox(
                height: height10,
              ),
              //SERVICE PROVIDER TEXT
              Text(
                StringConstants.ABOUT_PAGE_WHAT_SET_MKHOSI_APART,
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.justify,
              ),
              //space
              SizedBox(
                height: height10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
