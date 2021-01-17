import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/string_constants.dart';

class RatingInfoPage extends StatefulWidget {
  RatingInfoPage({Key key}) : super(key: key);

  @override
  _RatingInfoPageState createState() => _RatingInfoPageState();
}

class _RatingInfoPageState extends State<RatingInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Your Rating',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Understanding your rating',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                StringConstants.understandRating,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0),
              Image(
                image: AssetImage(
                  "assets/images/rating.jpg",
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'How your rating is calculated?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                StringConstants.HOWRATINGCALUCLATEDP1,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0),
              Text(
                StringConstants.HOWRATINGCALUCLATEDP2,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0),
              Text(
                'Safety',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                StringConstants.SAFETYTXT,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0),
              Text(
                'Why your rating matters?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                StringConstants.WHY_RATING_MATTERS,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
