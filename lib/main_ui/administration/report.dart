import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {

  final _formKey = GlobalKey<FormState>();

  String issue,description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sizeBox(30),
            Text('Report a Problem',style: TextStyle(
              color: AppColors.REPORT_TEXT1,fontWeight: FontWeight.w400,fontSize: 20,
            ),),
            sizeBox(15),
            Text('If you are experiencing any issues, please contact us',style: TextStyle(
              color: AppColors.REPORT_TEXT1,fontWeight: FontWeight.w400,fontSize: 15,
            ),),
            sizeBox(20),
            textFieldList(70, 'State the issue',
                    (val) =>
                    val.isEmpty ? 'please enter issue' : null,
                    (value){
              issue=value;
                    }),

            sizeBox(20),
            textFieldList(100, 'Description',
                  (val) =>
                  val.isEmpty ? 'please enter description' : null,
                    (value){
              description=value;
                    }
            ),
            sizeBox(15),
            GestureDetector(
              onTap: ()async{
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                  final Email email1 = Email(
                    recipients: ['support@mkhosi.com'],

                    body: 'Issue :  $issue \n\n Description :  $description',
                    subject: 'Report',
                    isHTML: false,
                  );
                  await FlutterEmailSender.send(email1).catchError(
                          (error){
                        print(error);

                      });
                }
                // Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.COLOR_PRIMARY
                ),
                child: Center(
                  child: Text('Submit',style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18
                  ),),
                ),
              ),
            ),
            sizeBox(10)
          ],
        ),
      ),
    );
  }

  Widget textFieldList(double height, String text,Function validator, Function onSaved){
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          hintText: '   $text',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

}
