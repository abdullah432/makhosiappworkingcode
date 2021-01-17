import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
      content: Column(
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
          textFieldList(50, 'State the issue'),
          sizeBox(20),
          textFieldList(100, 'Description'),
          sizeBox(15),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
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
    );
  }

  Widget textFieldList(double height, String text){
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
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
