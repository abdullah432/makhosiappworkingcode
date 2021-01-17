import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class SickNote extends StatefulWidget {
  @override
  _SickNoteState createState() => _SickNoteState();
}

class _SickNoteState extends State<SickNote> {

  List _documentList=[
    'ID Number:',
    'Date Consulted',
    'Reason',
  ];
  bool checkedValue=true;

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
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('#XXXXX-Z1.80',style: TextStyle(
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
                    Text('Practitioners’ Notes',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w500,fontSize: 12,
                      ),),
                    SizedBox(
                      height: 10,
                    ),
                    largeTextFieldList(),
                    SizedBox(
                      height: 15,
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
                    Container(
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
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldList(){
    return Container(
      height: 50,
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
  Widget largeTextFieldList(){
    return Container(
      height: 150,
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


  Widget textFieldListWithIcon(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(Icons.add,color: AppColors.COLOR_PRIMARY,size: 35,),
            ),
          ],
        ),
      ),
    );
  }

}
