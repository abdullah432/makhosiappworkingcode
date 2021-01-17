import 'package:flutter/material.dart';
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

  bool _obscure1=false;
  bool _obscure2=false;
  bool _obscure3=false;

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
                              builder: (context)=> CreateInvoice()
                          ));
                        },
                        child: containerList('Generate Client Invoices')),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> SickNote()
                          ));
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
                              builder: (context)=> CreateQuotation()
                          ));
                        },
                        child: containerList('Create Quotations')),
                    GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> RequestDocument()
                          ));
                        },
                        child: containerList('Request Tax Documentations')),

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
          return StatefulBuilder(
            builder: (context,setState){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Create Coupons',style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 24,
                    ),),
                    sizeBox(20),
                    Text('Name of  Client',style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
                    ),),
                    textFiled(_obscure1,(){
                      setState(() {
                        _obscure1 = !_obscure1;
                      });
                    }),
                    sizeBox(10),
                    Text('Email Address',style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
                    ),),
                    textFiled(_obscure2,(){
                      setState(() {
                        _obscure2 = !_obscure2;
                      });
                    }),
                    sizeBox(10),
                    Text('Discount Given (as %)',style: TextStyle(
                      color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
                    ),),
                    textFiled(_obscure3,(){
                      setState(() {
                        _obscure3 = !_obscure3;
                      });
                    }),
                    sizeBox(20),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                       couponDoneDialog();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.COLOR_PRIMARY
                        ),
                        child: Center(
                          child: Text('Send Coupon',style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  couponDoneDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images/administration_images/offer.png',height: 150,),
                Text('Coupon Created!',style: TextStyle(
                  color: AppColors.COUPON_TEXT2,fontWeight: FontWeight.w400,fontSize: 20,
                ),),

                Text('You have successfully created a coupon.',style: TextStyle(
                  color: AppColors.COUPON_TEXT3,fontWeight: FontWeight.w400,fontSize: 16,
                ),),
                sizeBox(25),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.COLOR_PRIMARY
                    ),
                    child: Center(
                      child: Text('OK',style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18
                      ),),
                    ),
                  ),
                ),
                sizeBox(20),
              ],
            ),
          );
        }
        );
    }

  Widget textFiled(bool obscure, Function onTap){
    return TextFormField(
      initialValue: '●●●●●●●●',
      obscureText: obscure,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            !obscure ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }
}

