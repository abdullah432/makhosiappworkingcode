import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themecolor,
      appBar: AppBar(
        backgroundColor: AppColors.darkbrown,
        toolbarHeight: 60,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
        onTap: (){Navigator.of(context).pop();},
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Text("Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
            ],
          ),

          ListTile(
            leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("MegaShop", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("04min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                ),
              ],
            ),
            subtitle: Text("submitted on invoice for you order45.pdf", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
            trailing: Image(image: AssetImage('images/ic_file.png'),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Thandi Dube", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("04min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                  ),
                ],
              ),
              subtitle: Text("has booked a session for 2020/09/02, 13h00 - 15h00", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
              trailing: Image(image: AssetImage('images/ic_chat.png'),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Card(
                      elevation: 1,
                      shadowColor: Colors.black38,
                      color: AppColors.darkbrown,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.clear, color: Colors.white, size: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Ignore', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'Poppins'),),
                            ),
                          ],
                        ),
                      ),)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Container(
                    height: 44,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Card(
                        elevation: 1,
                        shadowColor: Colors.black38,
                        color: Colors.yellow,
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.black, size: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Accept', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: 'Poppins'),),
                              ),
                            ],
                          ),
                        ),)),
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Newman Tiou", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("05min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                  ),
                ],
              ),
              subtitle: Text("confirmation of booking", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
              trailing: Image(image: AssetImage('images/ic_calendar.png'),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Makro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("06min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                  ),
                ],
              ),
              subtitle: Text("deleted the last invoice neworder.pdf", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
              trailing: Image(image: AssetImage('images/ic_delete.png'),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Card(
                      elevation: 1,
                      shadowColor: Colors.black38,
                      color: AppColors.darkbrown,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.clear, color: Colors.white, size: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Ignore', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'Poppins'),),
                            ),
                          ],
                        ),
                      ),)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:12.0),
                  child: Container(
                    height: 44,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Card(
                        elevation: 1,
                        shadowColor: Colors.black38,
                        color: Colors.yellow,
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.black, size: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Accept', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black, fontFamily: 'Poppins'),),
                              ),
                            ],
                          ),
                        ),)),
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Newman Tiou", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("05min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                  ),
                ],
              ),
              subtitle: Text("confirmation of booking", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
              trailing: Image(image: AssetImage('images/ic_calendar.png'),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              leading: Image.asset('images/circleavater.png',height: 50,width: 50,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Makro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("06min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
                  ),
                ],
              ),
              subtitle: Text("deleted the last invoice neworder.pdf", style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Poppins'),),
              trailing: Image(image: AssetImage('images/ic_delete.png'),),
            ),
          ),

        ],
      ),
    );
  }
}
