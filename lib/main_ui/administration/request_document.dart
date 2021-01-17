import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class RequestDocument extends StatefulWidget {
  @override
  _RequestDocumentState createState() => _RequestDocumentState();
}

class _RequestDocumentState extends State<RequestDocument> {

  final _formKey = GlobalKey<FormState>();

  // List _documentList=[
  //   'CIPC Company Registration No.',
  //   'Period Date',
  //   'Service Registered ',
  //   'Email',
  // ];

  String requestReason,dueDate, serviceRegistered,email;
  DateTime selectedDate;

  bool checkedValue=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.REQUEST_UPPER,
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
                Text('Request Documentation',style: TextStyle(
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
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Text('The following documents are requested for annual returns',
                        style: TextStyle(
                          color: AppColors.REQUEST_BOTTOM,fontWeight: FontWeight.w800,fontSize: 18,
                        ),),
                      SizedBox(height: 15,),
                      Text('Once the request has been received, it will be processed within 3 - 5 working days,.  Please feel free contact us in the event that you recieve no response',
                        style: TextStyle(
                          color: AppColors.REQUEST_TEXT,fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                      SizedBox(height: 15,),

                      Text('Reason for request',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                      SizedBox(
                        height: 6,
                      ),
                      textFieldList(
                              (val) =>
                          val.isEmpty ? 'please enter reason' : null,
                              (value){
                            requestReason = value;
                          }
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text('Period Date',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                      SizedBox(
                        height: 6,
                      ),
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
                      SizedBox(
                        height: 6,
                      ),
                      Text('Service Registered ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                      SizedBox(
                        height: 6,
                      ),
                      textFieldList(
                              (val) =>
                          val.isEmpty ? 'please enter service registered' : null,
                              (value){
                            serviceRegistered = value;
                          }
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text('Email',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                        ),),
                      SizedBox(
                        height: 6,
                      ),
                      textFieldList(
                              (val) =>
                          !val.contains('@') ? 'Invalid email' : null,
                              (value){
                            email = value;
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
                      SizedBox(height: 17,),
                      Text('Additional',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                        ),),

                      Align(
                        alignment: Alignment.topLeft,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.all(0),
                          activeColor: AppColors.CHECK_BOX,
                          title: Text("I require assistance understanding my business report",style: TextStyle(
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
                        onTap: ()async{
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            // createInvoice();
                            if(dueDate!=null && checkedValue){
                            final Email email1 = Email(
                              recipients: ['support@mkhosi.com'],

                              body: 'Reason for request :  $requestReason \n\n DueDate :  $dueDate \n\n'
                                  ' Service Registered :  $serviceRegistered \n\n Email :  $email ',
                              subject: 'Request Document',
                              isHTML: false,
                            );
                            await FlutterEmailSender.send(email1).catchError(
                                    (error){
                              print(error);

                            });
                          }
                            else{
                              dialog3();
                            }
                          }
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.REQUEST_UPPER
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send,color: Colors.white,),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Submit Request',style: TextStyle(
                                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

 Widget textFieldList(Function validator, Function onSaved){
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
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

}
