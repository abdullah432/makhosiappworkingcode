import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/main_ui/backend/client_list.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/consultations.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:screenshot/screenshot.dart';

class CreateInvoice extends StatefulWidget {
  final bool serviceCheck;

  CreateInvoice({this.serviceCheck});

  @override
  _CreateInvoiceState createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {

  Random random = new Random();
  final _formKey = GlobalKey<FormState>();
  ScreenshotController screenshotController = ScreenshotController();

  int randomNumber;
  DateTime selectedDate;
  String dueDate;
  String clientId,email,name;
  bool check=true;

  bool _showSpinner =false;
  File image1;

  @override
  void initState() {
    randomNumber = random.nextInt(100000);
    print(randomNumber);
    // getData();
    super.initState();
  }

  takeShot()async{
    print('sa');

    image1 = await screenshotController.capture(
        pixelRatio: 4
    );
    setState(() {
      print('sad');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text((widget.serviceCheck)?'Create Invoice':'Create Quotation',
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
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
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
                              Text((widget.serviceCheck)?'Invoice No.':'Quotation No.',style: TextStyle(
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
                              Text('$randomNumber-Z79.80',style: TextStyle(
                                color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                              ),),
                              expanded(),
                              GestureDetector(
                                onTap: (){
                                  selectDate(context);
                                },
                                child: Text((dueDate!=null)?dueDate:'00/00/2000',style: TextStyle(
                                  color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              ),
                              expanded(),
                            ],
                          ),
                          Divider(),
                          sizeBox(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: ()async{
                                  await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ClientList())).then((value){
                                    print(value.email);
                                    print(value.name);
                                    setState(() {
                                      email=value.email;
                                      name = value.name;
                                    });
                                  });

                                },
                                child: Text((name!=null)?name:(widget.serviceCheck)?'Invoice To':'Quotation To.',style: TextStyle(
                                  color: AppColors.Invoice_TEXT1,fontWeight: FontWeight.w400,fontSize: 12,
                                ),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Text((email!=null)?email:'Client Email',style: TextStyle(
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
                          Text('You have ${items.length} items',style: TextStyle(
                            color: AppColors.Invoice_APPBAR_TEXT_O,fontWeight: FontWeight.w400,fontSize: 12,
                          ),),
                          sizeBox(15),
                          GestureDetector(
                            onTap: (){
                              dialog1();
                            },
                            child: Container(
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
                          ),
                          Divider(),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${index + 1 }. ${items[index]['item']}',style: TextStyle(
                                        color: AppColors.Invoice_APPBAR_TEXT_O,fontWeight: FontWeight.w400,fontSize: 13,
                                      ),),

                                      Text('R. ${items[index]['price']}',style: TextStyle(
                                        color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                                      ),)

                                    ],
                                  ),
                                );
                              }),
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
                              Text((subTotal!=0.0)?'R. ${subTotal.toString()}':'R 0.00',style: TextStyle(
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
                              Text((discountPercentage!=0.0)?'${discountPercentage.toString()} %':'0 %',style: TextStyle(
                                color: AppColors.Invoice_APPBAR_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                              ),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: (){
                                    dialog2();
                                  },
                                  child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.Invoice_APPBAR_TEXT,size: 15,))
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
                              Text('15 %',style: TextStyle(
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
                              Text((grandTotal!=0.0)?'R $grandTotal':'R 0.00',style: TextStyle(
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
                ],
              ),
            ),
            sizeBox(60),
            GestureDetector(
                onTap: ()async{

                  await createInvoice();
                },
                child: buttonContainer((widget.serviceCheck)?'Create Invoice':'Create Quotation')),
            sizeBox(20),
            GestureDetector(
                onTap: ()async{
                  if(dueDate!=null && email!=null && name !=null && items.length!=0 && subTotal!=null) {
                    await takeShot();
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            Consultations(image: image1,)
                        ));
                  }
                  else{
                    dialog3();
                  }
                },
                child: buttonContainer('Send to Client')),
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

  Future<DateTime> _selectDateTime(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }

  selectDate(BuildContext context)async{

    final selectedDate = await _selectDateTime(context);
    if (selectedDate == null) return;


    setState(() {
      this.selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
    });

    print(this.selectedDate);
    String formattedDate = DateFormat('dd/MM/yyyy').format(this.selectedDate);
    setState(() {
      dueDate =formattedDate;
    });

  }


  List items=[];

String itemName;
double itemPrice;
double subTotal=0.0;
double discountPercentage=0.0;
double grandTotal=0.0;

  dialog1(){
    showDialog(context: (context),
    builder: (context){
      return AlertDialog(
        title: Text('Add items'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? 'please enter item' : null,
                onSaved: (value){
                  itemName=value;
                },
                decoration: InputDecoration(
                  hintText: 'item'
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) =>
                val.isEmpty ? 'please enter price' : null,
                onSaved: (value){
                  itemPrice=double.parse(value);
                },
                decoration: InputDecoration(
                  hintText: 'price'
                ),
              )
            ],
          ),
        ),
        actions: [
          FlatButton(onPressed: (){
            final form = _formKey.currentState;
            if (form.validate()) {
              form.save();
              items.add({
                'item':itemName,
                'price': itemPrice,
              });
              subTotal=0;
              for(int i =0; i<items.length; i++){
                print(items[i]['price']);
                subTotal = subTotal + items[i]['price'];
                print(subTotal);
              }
              double a = subTotal * 0.15;
              double b = subTotal * (discountPercentage/100);

              grandTotal = subTotal + a - b;

              Navigator.pop(context);
            }

          }, child: Text('confirm')),
          FlatButton(onPressed: (){
            Navigator.pop(context,true);
          }, child: Text('Cancel')),
        ],
      );
    }
    );
  }

  dialog2(){
    showDialog(context: (context),
        builder: (context){
          return AlertDialog(
            title: Text('Discount percentage'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                    val.isEmpty ? 'please enter discount percentage' : null,
                    onSaved: (value){
                      discountPercentage=double.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Percentage'
                    ),
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(onPressed: (){
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                    double a = subTotal * 0.15;
                    double b = subTotal * (discountPercentage/100);

                    grandTotal = subTotal + a - b;

                  Navigator.pop(context);
                }

              }, child: Text('confirm')),
              FlatButton(onPressed: (){
                Navigator.pop(context,true);
              }, child: Text('Cancel')),
            ],
          );
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
                Text('Please Fill all the data above')
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

  createInvoice()async{
    String createdDate = DateFormat('yMMMMd').format(DateTime.now());

    if(dueDate!=null && email!=null && name !=null && items.length!=0 && subTotal!=null){
    try {
      setState(() {
        _showSpinner=true;
      });
      String uid = FirebaseAuth.instance.currentUser.uid;

      await FirebaseFirestore.instance.collection('patients').where(
          'email', isEqualTo: email).get().then((value) {
        value.docs.forEach((element) {
          print(element.id);
          clientId = element.id;
        });
      }).then((value) async {
        await FirebaseFirestore.instance.collection('Invoices').add({
          'clientName': name,
          'clientId': clientId,
          'Uid': uid,
          'dueDate': dueDate,
          'invoice.NO': '$randomNumber-Z79.80',
          'invoiceItems': items,
          'subTotal': subTotal,
          'discount': discountPercentage,
          'grandTotal': grandTotal,
          'createdDate':createdDate,
          'category': (widget.serviceCheck) ? 'invoice' : 'quotation',
        });
      }).then((value) {
        Navigator.pop(context);
      });
    }catch(e){
      Navigator.pop(context);
      print(e);
    }
  }
    else{
      dialog3();
    }
  }

}
