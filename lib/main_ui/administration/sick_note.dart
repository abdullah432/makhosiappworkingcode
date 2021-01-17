import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/helper/validator.dart';
import 'package:makhosi_app/main_ui/backend/client_list.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/other/consultations.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:screenshot/screenshot.dart';

class SickNote extends StatefulWidget {
  @override
  _SickNoteState createState() => _SickNoteState();
}

class _SickNoteState extends State<SickNote> {

  Random random = new Random();
  ScreenshotController screenshotController = ScreenshotController();
  final _formKey = GlobalKey<FormState>();

  int randomNumber;
  DateTime selectedDate;
  String dueDate;
  String clientId,email,name,idNumber,reason,notes;
  bool _showSpinner =false;
  File image1;

  List _documentList=[
    'ID Number:',
    'Date Consulted',
    'Reason',
  ];
  bool checkedValue=false;

  @override
  void initState() {
    randomNumber = random.nextInt(100000);
    print(randomNumber);
    super.initState();
  }

  takeShot()async{

    image1 = await screenshotController.capture(
        pixelRatio: 4
    );
    setState(() {
      print('sad');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
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
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 18,)),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text('Sick Note Form',style: TextStyle(
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
                  padding: EdgeInsets.symmetric(horizontal:30.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Screenshot(
                          controller: screenshotController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Text('$randomNumber-Z79.80',style: TextStyle(
                                  color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              ),
                              Text('Sick Note for:',style: TextStyle(
                                color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w800,fontSize: 18,
                              ),),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Patient Name',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              textFieldListWithIcon(),
                              SizedBox(
                                height: 10,
                              ),
                              Text('ID Number',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              textFieldList(
                                      (val) =>
                                  val.isEmpty ? 'please enter Id Number' : null,
                                      (value){
                                    idNumber=value;
                                  }
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Date Consulted',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              GestureDetector(
                                onTap: (){
                                  selectDate(context);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                              (dueDate!=null)?dueDate:'00/00/200'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // textFieldList(),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Reason',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              textFieldList(
                                      (val) =>
                                  val.isEmpty ? 'please enter reason' : null,
                                      (value){
                                    reason = value;
                                  }
                              ),
                              // ListView.builder(
                              //   physics: NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemCount: _documentList.length,
                              //   itemBuilder: (context,index){
                              //     return Padding(
                              //       padding: EdgeInsets.symmetric(vertical: 6),
                              //       child: Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           Text(_documentList[index],
                              //             style: TextStyle(
                              //               color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                              //             ),),
                              //           SizedBox(
                              //             height: 6,
                              //           ),
                              //           textFieldList(),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Practitioners’ Notes',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              SizedBox(
                                height: 10,
                              ),
                              largeTextFieldList(
                                      (val) =>
                                  val.isEmpty ? 'please enter practitioners’ notes' : null,
                                      (value){
                                    notes = value;
                                  }
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            activeColor: AppColors.CHECK_BOX,
                            title: Text("I acknowledge that the information submitted above is correct",style: TextStyle(
                              color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w600,fontSize: 12,
                            ),),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                        SizedBox(height: 17,),
                        GestureDetector(
                          onTap: (){
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              createInvoice();
                            }
                          },
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.COLOR_PRIMARY
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send,color: Colors.white,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Create Sick Notes',style: TextStyle(
                                    color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: ()async{
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              if(dueDate!=null && email!=null && name !=null && idNumber!=null &&
                                  reason!=null && notes!=null && checkedValue)
                              {
                                await takeShot();
                                await Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        Consultations(image: image1,)
                                    ));
                              }
                              else{
                                dialog3();
                              }
                            }

                          },
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.COLOR_PRIMARY
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send,color: Colors.white,),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Send to Client',style: TextStyle(
                                      color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldList(Function validator, Function onSaved){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:10.0),
          child: TextFormField(
            validator: validator,
            onSaved: onSaved,
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget largeTextFieldList(Function validator,Function onSaved){
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
        child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration.collapsed(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget textFieldListWithIcon(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  (name!=null)?name:'Patient Name'
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 14),
              child: GestureDetector(
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
                  child: Icon(Icons.add,color: AppColors.COLOR_PRIMARY,size: 35,)),
            ),
          ],
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

    if(dueDate!=null && email!=null && name !=null && idNumber!=null && reason!=null && notes!=null && checkedValue){
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
          await FirebaseFirestore.instance.collection('SickNotes').add({
            'clientName': name,
            'clientId': clientId,
            'Uid': uid,
            'dueDate': dueDate,
            'invoice.NO': '$randomNumber-Z79.80',
            'idNumber': idNumber,
            'reason': reason,
            'notes': notes,
            'createdDate':createdDate,
            'category':  'Sick notes',
          });
        }).then((value) {
          Navigator.pop(context);
        });
      }catch(e){
        print(e);
        Navigator.pop(context);

      }
    }
    else{
      dialog3();
    }
  }
}
