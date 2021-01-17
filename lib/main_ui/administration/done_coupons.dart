import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class CouponDone extends StatefulWidget {
  @override
  _CouponDoneState createState() => _CouponDoneState();
}

class _CouponDoneState extends State<CouponDone> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/administration_images/offer.png',height: 150,),
          Text('Coupon Created!',style: TextStyle(
            color: AppColors.COUPON_TEXT2,fontWeight: FontWeight.w400,fontSize: 20,
          ),),

          Text('You have successfully created a coupon.',style: TextStyle(
            color: AppColors.COUPON_TEXT3,fontWeight: FontWeight.w400,fontSize: 16,
          ),),
          sizeBox(25),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.COLOR_PRIMARY
              ),
              child: Center(
                child: Text('OK',style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18
                ),),
              ),
            ),
          ),
          sizeBox(20),
        ],
      ),
    );
  }
  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }

}
