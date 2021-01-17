import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/administration/chart.dart';
import 'package:makhosi_app/main_ui/administration/report.dart';
import 'package:makhosi_app/main_ui/administration/request.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/Screens/account_screen.dart';
import 'package:makhosi_app/Screens/bottomnav.dart';
import 'package:makhosi_app/main_ui/administration/report.dart';
class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {


  @override
  void initState() {
    super.initState();
    getData();
  }
  Map<String, dynamic> profileVisit;
  int totalClient;

  getData()async{
    String id = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('bookings').where('appointment_to', isEqualTo: id).get().then((value) {
      setState(() {
        totalClient =value.docs.length;
      });
    });
    await FirebaseFirestore.instance.collection('service_provider').doc(id).get().then((value){
      setState(() {
        profileVisit =value.data();
      });
    });
    


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomContainer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:
        ListView(
          children: [
            sizeBox(20),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            sizeBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Admin Portal',style: TextStyle(
                  color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w800,fontSize: 26,
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=> Request()
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.CHECK_BOX
                    ),
                    child: Center(
                      child: Text('+ Requests',style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10,
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            sizeBox(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               detailsContainer('Total Clients', AppColors.REQUEST_UPPER,totalClient),
               detailsContainer1('Total No. of Profile Visits', AppColors.COLOR_PRIMARY,profileVisit)
              ],
            ),
            sizeBox(30),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Last 6 month',style: TextStyle(
                color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
              ),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Client Trends',style: TextStyle(
                    color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w800,fontSize: 18,
                  ),),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black.withOpacity(.10)
                    ),
                    child: Center(
                      child: Text('2020',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            sizeBox(20),
            Container(
                height: 260,
                child: Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text('(Total No. in Clients Gained)',style: TextStyle(
                        color: Colors.black.withOpacity(.40),fontWeight: FontWeight.w600,fontSize: 11,
                      ),),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Chart1()),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget detailsContainer(String text, Color color, int number){
    double width =MediaQuery.of(context).size.width;
    return Stack(
      // alignment: Alignment.center,
      children: [
        Container(
          height: 190,
          width: width*.41,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 30,right: 20, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.description_outlined,color: Colors.white,size: 35,),
                sizeBox(20),
                (number!=null)?Text(number.toString(),style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18,
                ),):Center(child: CircularProgressIndicator(),),
                Text(text,style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14,
                ),),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.12)
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          left: -5,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.12)
            ),
          ),
        ),
      ],
    );
  }
  Widget detailsContainer1(String text, Color color, Map data){
    double width =MediaQuery.of(context).size.width;
    return Stack(
      // alignment: Alignment.center,
      children: [
        Container(
          height: 190,
          width: width*.41,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 30,right: 20, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.description_outlined,color: Colors.white,size: 35,),
                sizeBox(20),
                (data!=null)?Text((data['profileVisit'] !=null)?data['profileVisit'].toString(): '0',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18,
                ),):Center(child: CircularProgressIndicator(),),
                Text(text,style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14,
                ),),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.12)
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          left: -5,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.12)
            ),
          ),
        ),
      ],
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

  Widget bottomContainer(){
    return Container(
      child: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(
            color: AppColors.REQUEST_BOTTOM
        ),
        selectedLabelStyle: TextStyle(
            color: AppColors.REQUEST_BOTTOM
        ),
        selectedIconTheme: IconThemeData(color: AppColors.REQUEST_BOTTOM,),
        unselectedItemColor: AppColors.REQUEST_BOTTOM,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        selectedItemColor: AppColors.REQUEST_BOTTOM,
        unselectedIconTheme: IconThemeData(color: AppColors.REQUEST_BOTTOM,),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          if(index==0){
            Navigator.pop(context);
          }
          if(index==1){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> MainDashboardScreen()
            ));
          }
          else if(index==2){
            showDialog(
                context: context,
                builder: (context){
                  return Report();
                }
            );
          }
          print(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/administration_images/home.png"),
              color: AppColors.REQUEST_BOTTOM,
//                 size: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/administration_images/business_data.png"),
              color: AppColors.REQUEST_BOTTOM,
//                 size: (_page ==1 )? 30: 25,
            ),
            label: 'Business Data Room',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/administration_images/report.png"),
             color: AppColors.REQUEST_BOTTOM,
            // size: (_page ==1 )? 30: 25,
    ),

            label: 'Report a Problem',
          ),
        ],
      ),
    );
  }

}
