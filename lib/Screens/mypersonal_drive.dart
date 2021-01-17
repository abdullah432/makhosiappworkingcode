import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';
import 'package:makhosi_app/Assets/custom_listtile.dart';

class MyPersonalStorage extends StatefulWidget {
  @override
  _MyPersonalStorageState createState() => _MyPersonalStorageState();
}

class _MyPersonalStorageState extends State<MyPersonalStorage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themecolor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Text("My Personal Drive", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image(image: AssetImage('images/storage_icon.png'),),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Free Storage", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text("7.5 Gb", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'Poppins'),),
                      ),
                      Text("From Total 10 Gb", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey, fontFamily: 'Poppins'),),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 80),
            child: Column(
              children: [
                notification_alert(title: "Notifications",),
                HelpandFeeback(title: "Help & feedback",),
              ],
            ),
          ),

          FlatButton(onPressed: null, child: Card(
            elevation: 5,
            color: AppColors.accentcolor,
            shadowColor: AppColors.accentcolor,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(child: Text('Upgrade Storage', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),),
            ),
          )),

          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 50),
            child: Column(
              children: [
                returnBtn(title: "Return to Profile",),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
