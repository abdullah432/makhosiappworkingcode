import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/administration/create_coupons.dart';
import 'package:makhosi_app/main_ui/administration/done_coupons.dart';
import 'package:makhosi_app/main_ui/administration/sick_note.dart';
import 'package:makhosi_app/main_ui/business_card/businessCard.dart';
import 'package:makhosi_app/utils/app_colors.dart';

import 'coupons_invoices_quotation.dart';
import 'create_invoice.dart';
import 'create_quotation.dart';
import 'report.dart';
import 'request_document.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  List _createCoupon=[
    'Name of  Client',
    'Email Address',
    'Discount Given (as %)',
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.REQUEST_UPPER,
      bottomNavigationBar: bottomContainer(),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
               GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,)),
                Expanded(
                  child: SizedBox(),
                ),
                Text('Request',style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18,
                ),),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30) ,
                  topLeft: Radius.circular(30),
                ),
                color: Colors.grey[50]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:40.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> CouponsInvoicesQuotation()
                          ));
                        },
                        child: containerList('View Coupons/Invoices/Quotations')),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> CreateInvoice(serviceCheck: true,)
                          ));
                        },
                        child: containerList('Generate Client Invoices')),
                    GestureDetector(
                        onTap: (){
                          get();

                        },
                        child: containerList('Generate Client Sick Note')),
                    GestureDetector(
                        onTap: (){
                          couponDialog(context);
                        },
                        child: containerList('Create Coupons ')),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> CreateInvoice(serviceCheck: false,)
                          ));
                        },
                        child: containerList('Create Quotations')),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> RequestDocument()
                          ));
                        },
                        child: containerList('Request your business report')),

                    Divider(
                      thickness: 1.5,
                    ),
                    Text('Please make sure that all information provided to the Client is always verified.',
                      style: TextStyle(
                      color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                    ),),

                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text('@2020. Olintshi Tech (Pty) Ltd',
                        style: TextStyle(
                          color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
                builder: (context)=> BusinessCard()
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
//                  color: Colors.white,
//                 size: 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/administration_images/business_data.png"),
//                  color: Colors.white,
//                 size: (_page ==1 )? 30: 25,
            ),
            label: 'Business Data Room',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("images/administration_images/report.png"),
              color: AppColors.REQUEST_BOTTOM,
            ),
            label: 'Report a Problem',
          ),
        ],
      ),
    );
  }

  Widget containerList(String text,){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.REQUEST_UPPER
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width:50,
            ),
            Icon(Icons.send,color: Colors.white,),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(text,style: TextStyle(
                color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13,
              ),),
            ),
          ],
        ),
      ),
    );
  }

  couponDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return CreateCoupon();
        }
    );
  }


  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

  get()async{
    String uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance.collection('service_provider').doc(uid).get().then((value) {
      print(value.get('service_type'));
      if(value.get('service_type')== 'Abelaphi'){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> SickNote()
      ));
    }
      else{
        dialog3();
      }
    }
      );

  }

  dialog3(){
    showDialog(context: (context),
        builder: (context){
          return AlertDialog(
            title: Text('Warning'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You don\'t have the permission')
              ],
            ),
            actions: [
              FlatButton(onPressed: (){
                Navigator.pop(context,true);
              }, child: Text('Ok')),
            ],
          );
        }
    );
  }

}

