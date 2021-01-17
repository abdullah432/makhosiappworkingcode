import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';
import 'package:makhosi_app/Assets/custom_listtile.dart';

class ClientRecords extends StatefulWidget {
  @override
  _ClientRecordsState createState() => _ClientRecordsState();
}

class _ClientRecordsState extends State<ClientRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themecolor,
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage('images/ic_back.png')),
                Image(image: AssetImage('images/ic_popmenu.png')),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(image: AssetImage('images/ic_folder.png')),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Client Records", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("32 items . 350 Mb", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.grey, fontFamily: 'Poppins'),),
                    ),
                  ],
                ),

                Image(image: AssetImage('images/ic_search.png'), height: 50,),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text("Last update 10 October 2020 .", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.grey, fontFamily: 'Poppins'),),
          ),

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  height: 400,
                  width: 350,
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.all(12),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                              Icon(Icons.arrow_drop_down, color: Colors.grey,),
                              Padding(
                                padding: const EdgeInsets.only(left: 180.0),
                                child: Image(image: AssetImage('images/ic_filter.png')),
                              ),
                            ],
                          ),
                        ),

                        items12(title: '20200110-20001', subtitle: '12 items  .  10 Mb',),

                        items22(title: '20200110-20011', subtitle: '22 items  . 23 Mb',),

                        items40(title: '20200110-20001', subtitle: '40 items  .  33 Mb',),

                        items6(title: '20200110-20001', subtitle: '6 items  .  5 Mb',),

                        items24(title: '20200110-20001', subtitle: '24 items  .  27 Mb',),

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 15,
                  right: 15,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.accentcolor,
                    onPressed: null,
                    child: Icon(Icons.add, color: Colors.white,),
                      )),
            ],
          ),

        ],
      ),
    );
  }
}
