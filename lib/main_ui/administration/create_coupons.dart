import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makhosi_app/main_ui/backend/client_list.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'done_coupons.dart';

class CreateCoupon extends StatefulWidget {
  @override
  _CreateCouponState createState() => _CreateCouponState();
}

class _CreateCouponState extends State<CreateCoupon> {

  final _formKey = GlobalKey<FormState>();

  bool _obscure3=true;
  bool _showSpinner =false;

  String email,name,discount,clientId;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create Coupons',style: TextStyle(
              color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 24,
            ),),
            sizeBox(20),
            Text('Name of  Client',style: TextStyle(
              color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
            ),),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((name!=null)?name:'Name of the Client',style: TextStyle(
                      color: Colors.black54,
                    fontSize: 13
                  ),),
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
                      child: Icon(Icons.add,color: AppColors.COLOR_PRIMARY,size: 32,))
                ],
              ),
            ),
            sizeBox(10),
            Text('Email Address',style: TextStyle(
              color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
            ),),
            sizeBox(8),
            Container(
              child:Text((email!=null)?email:'Email Address',style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13
              ),),
            ),
            sizeBox(10),
            Text('Discount Given (as %)',style: TextStyle(
              color: AppColors.COLOR_PRIMARY,fontWeight: FontWeight.w400,fontSize: 12,
            ),),
            textFiled(_obscure3,(){
              setState(() {
                _obscure3 = !_obscure3;
              });
            },
                (value){
              discount=value;
                },
                  (val) =>
              val.isEmpty ? 'please enter discount' : null,
            ),
            sizeBox(20),
            (!_showSpinner)?GestureDetector(
              onTap: ()async{
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                 await  createInvoice();
                }

                // Navigator.pop(context);
                // couponDoneDialog();
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.COLOR_PRIMARY
                ),
                child: Center(
                  child: Text('Send Coupon',style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18
                  ),),
                ),
              ),
            ):Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

  Widget textFiled(bool obscure, Function onTap, Function onSaved,Function validator){
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      // initialValue: '●●●●●●●●',
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: 'Discount',
        hintStyle:TextStyle(
            color: Colors.black54,
            fontSize: 13
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            !obscure ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }

  couponDoneDialog(){
    showDialog(
        context: context,
        builder: (context){
          return CouponDone();
        }
    );
  }

  createInvoice()async{

    String createdDate = DateFormat('yMMMMd').format(DateTime.now());

    if(email!=null && name !=null){
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
          await FirebaseFirestore.instance.collection('Coupons').add({
            'clientName': name,
            'clientEmail':email,
            'clientId': clientId,
            'Uid': uid,
            'createdDate': createdDate,
            'discount': discount,
            'category':  'coupons',
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
