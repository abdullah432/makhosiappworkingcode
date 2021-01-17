import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/main_ui/backend/view_invoice.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class CouponsInvoicesQuotation extends StatefulWidget {
  @override
  _CouponsInvoicesQuotationState createState() => _CouponsInvoicesQuotationState();
}

class _CouponsInvoicesQuotationState extends State<CouponsInvoicesQuotation> {
  //
  // List _couponList=[
  //   {
  //     'text1':'Keith Katyora',
  //     'text2':'Invoice Submitted',
  //     'text3':'Date: 20 November 2020',
  //     'text4':'Paid',
  //   },
  //   {
  //     'text1':'Suneel Kumar',
  //     'text2':'Sick Note Requested',
  //     'text3':'Date: 12 December 2020',
  //     'text4':'Accepted',
  //   },
  //   {
  //     'text1':'Sibu Mvana',
  //     'text2':'Coupon Created for Client',
  //     'text3':'Date: 10 December 2020',
  //     'text4':'Submitted',
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.COLOR_PRIMARY,
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
                      // String createdDate = DateFormat('yMMMMd').format(DateTime.now());
                      // print(createdDate);
                      Navigator.pop(context);
                    },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,)),
                Expanded(
                  child: SizedBox(),
                ),
                Text('Coupons/Invoices/Quotation',style: TextStyle(
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
              child:
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal:30.0,vertical: 30),
              // child: ListView.builder(
              //     itemCount: _couponList.length,
              //     itemBuilder: (context,index){
              //       return Padding(
              //         padding: EdgeInsets.only(bottom:20.0),
              //         child: Container(
              //           height: 160,
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             border: Border.all(
              //               color: AppColors.COUPON_TEXT
              //             )
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal:30 ,vertical: 30),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(_couponList[index]['text1'],style: TextStyle(
              //                   color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w600,fontSize: 13,
              //                 ),),
              //                 sizeBox(5),
              //                 (index!=1)?Text(_couponList[index]['text2'],style: TextStyle(
              //                   color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w600,fontSize: 13,
              //                 ),):
              //                 Row(
              //                   children: [
              //                     Image.asset('images/administration_images/coupons1.png'),
              //                     SizedBox(width: 10,),
              //                     Text(_couponList[index]['text2'],style: TextStyle(
              //                       color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w600,fontSize: 13,
              //                     ),)
              //                   ],
              //                 ),
              //                 sizeBox(5),
              //                 Text(_couponList[index]['text3'],style: TextStyle(
              //                   color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w600,fontSize: 13,
              //                 ),),
              //                 sizeBox(5),
              //                 Text(_couponList[index]['text4'],style: TextStyle(
              //                   color: AppColors.COUPON_TEXT1,fontWeight: FontWeight.w500,fontSize: 13,
              //                 ),),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     }),
              // ),
              Column(
                children: [
                  sizeBox(30),
                  Expanded(
                    child: ListView(
                      children: [
                        ViewInvoice(name:'Invoices'),
                        ViewInvoice(name:'SickNotes'),
                        ViewInvoice(name:'Coupons'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }
}
