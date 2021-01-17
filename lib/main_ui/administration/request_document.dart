import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class RequestDocument extends StatefulWidget {
  @override
  _RequestDocumentState createState() => _RequestDocumentState();
}

class _RequestDocumentState extends State<RequestDocument> {

  List _documentList=[
    'CIPC Company Registration No.',
    'Period Date',
    'Service Registered ',
    'Email',
  ];

  bool checkedValue=true;
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
                    SizedBox(height: 5,),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _documentList.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_documentList[index],
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                                ),),
                              SizedBox(
                                height: 6,
                              ),
                              textFieldList(),
                            ],
                          ),
                        );
                      },
                    ),
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
                        title: Text("Require assistance with filing annual returns?",style: TextStyle(
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
                    Container(
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
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

 Widget textFieldList(){
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration.collapsed(
            border: InputBorder.none,
          ),
        ),
      ),
    );
 }
}
