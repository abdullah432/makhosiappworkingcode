import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class ViewInvoice extends StatefulWidget {
  final String name;

  ViewInvoice({this.name});

  @override
  _ViewInvoiceState createState() => _ViewInvoiceState();
}

class _ViewInvoiceState extends State<ViewInvoice> {
  
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
        BuildContext context) async* {
      yield* FirebaseFirestore.instance.collection(widget.name).where('Uid', isEqualTo:  uid)
          .snapshots();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: getUsersTripsStreamSnapshots(context),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final message = snapshot.data.docs;

        return Padding(
          padding: EdgeInsets.only(left:30.0,right:30,),
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: message.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(bottom:20.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.COUPON_TEXT
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:30 ,vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message[index]['clientName'],style: TextStyle(
                            color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w600,fontSize: 13,
                          ),),
                          sizeBox(5),
                          Text(check(message[index]['category']),style: TextStyle(
                            color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w600,fontSize: 13,
                          ),),
                              // :
                          // Row(
                          //   children: [
                          //     Image.asset('images/administration_images/coupons1.png'),
                          //     SizedBox(width: 10,),
                          //     Text(message[index]['text2'],style: TextStyle(
                          //       color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w600,fontSize: 13,
                          //     ),)
                          //   ],
                          // ),
                          sizeBox(5),
                          Text('Date: ${message[index]['createdDate']}',style: TextStyle(
                            color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w600,fontSize: 13,
                          ),),
                          // sizeBox(5),
                          // Text(message[index]['text4'],style: TextStyle(
                          //   color: AppColors.COUPON_TEXT1,fontWeight: FontWeight.w500,fontSize: 13,
                          // ),),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );


      },
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

  String check(String category){
    if(category == 'invoice'){
      return 'Invoice Submitted';
    }
    else if(category == 'quotation'){
      return 'Quotation Submitted';
    }
    else if(category == 'Sick notes'){
      return 'Sick Notes Submitted';
    }
    else if(category == 'coupons'){
      return 'Coupons Created for Client';
    }
    return '';
  }

}
