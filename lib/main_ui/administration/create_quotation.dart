import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class CreateQuotation extends StatefulWidget {
  @override
  _CreateQuotationState createState() => _CreateQuotationState();
}

class _CreateQuotationState extends State<CreateQuotation> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Create Quotation',
          style: TextStyle(
            color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 16,
          ),),
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(
          color: AppColors.REQUEST_UPPER,
        ),
      ),
      body: ListView(
        children: [
          // sizeBox(10),
          spaceContainer(10),
          Container(
            // height: 200,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Invoice No.',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      expanded(),
                      Text('Due Date',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      expanded(),
                    ],
                  ),
                  sizeBox(3),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('xxxxxx-Z79.80',style: TextStyle(
                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      expanded(),
                      Text('30/08/2018',style: TextStyle(
                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      expanded(),
                    ],
                  ),
                  Divider(),
                  sizeBox(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Invoice To.',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text('Client Email',style: TextStyle(
                          color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                        ),),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          spaceContainer(10),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invoice Items',style: TextStyle(
                    color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w500,fontSize: 12,
                  ),),
                  sizeBox(15),
                  Text('You have 0 items',style: TextStyle(
                    color: AppColors.Invoice_APPBAR_TEXT_O,fontWeight: FontWeight.w400,fontSize: 12,
                  ),),
                  sizeBox(15),
                  Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:AppColors.REQUEST_UPPER_O,
                    ),
                    child: Center(
                      child: Text('Add Item',style: TextStyle(
                        color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          spaceContainer(10),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      expanded(),
                      Text('R0.00',style: TextStyle(
                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  sizeBox(5),
                  Divider(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      expanded(),
                      Text('0%',style: TextStyle(
                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_rounded,color: AppColors.Invoice_APPBAR_TEXT,size: 15,)
                    ],
                  ),
                  sizeBox(5),
                  Divider(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax',style: TextStyle(
                        color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                      ),),
                      expanded(),
                      Text('R0.00',style: TextStyle(
                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_rounded,color: AppColors.Invoice_APPBAR_TEXT,size: 15,)
                    ],
                  ),
                  sizeBox(5),
                  Divider(),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total',style: TextStyle(
                        color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      expanded(),
                      Text('R0.00',style: TextStyle(
                        color: AppColors.REQUEST_UPPER,fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          spaceContainer(40),
          sizeBox(60),
          buttonContainer('Create Invoice'),
          sizeBox(20),
          buttonContainer('Send to Client'),
          sizeBox(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .3),
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black
              ),
            ),
          ),
          sizeBox(10),
        ],
      ),
    );
  }

  Widget expanded(){
    return Expanded(
      child: SizedBox(),
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

  Widget spaceContainer(double height){
    return Container(
      height: height,
      width: double.infinity,
      color: AppColors.REQUEST_UPPER_O,
    );
  }

  Widget buttonContainer(String text){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.REQUEST_UPPER
        ),
        child: Center(
          child:  Text(text,style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.w500,fontSize: 12,
          ),),
        ),
      ),
    );
  }
}
