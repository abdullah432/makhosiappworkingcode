import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:makhosi_app/Assets/app_assets.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.browncolor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.arrow_back_sharp, color: Colors.white,)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Summary \nReport", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/circleavater.png'),),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("1 month", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white70, fontFamily: 'Poppins'),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 48,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.white70,
                          color: AppColors.accentcolor,
                          child: Center(child: Text('3 months', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("6 months", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white70, fontFamily: 'Poppins'),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("1 year", style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white70, fontFamily: 'Poppins'),),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.white70,
                          color: AppColors.accentcolor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('R36 138', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Total Earnings', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.white70,
                          color: AppColors.accentcolor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('R23, 000', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Consultations', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.white70,
                          color: AppColors.accentcolor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('R204', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Sales from Orders', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.black87,
                          color: Colors.red,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('38', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Total Clients', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.black87,
                          color: Colors.deepPurple,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Active sessions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Card(
                          elevation: 2,
                          shadowColor: Colors.black87,
                          color: Colors.orange,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                                  Text('Sessions Pending', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, fontFamily: 'Poppins'),),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:50.0, left: 8, right: 8),
            child: Container(
              height: 100,
              child: Card(
                color: AppColors.themecolor,
                elevation: 2,
                shadowColor: Colors.black12,
                child: Center(
                  child: ListTile(
                    leading: Image(image: AssetImage('images/ic_support.png'),),
                    title: Text('Help & Support Line', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins'),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('24/7 Chat Support', style: TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'Poppins'),),
                    ),
                    trailing: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_forward, color: AppColors.themecolor,),
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
