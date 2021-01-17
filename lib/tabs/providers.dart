
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hexcolor/hexcolor.dart';


class providers extends StatefulWidget {
  // static List mydata;

  @override
  _FrequentProductsState createState() => _FrequentProductsState();
}

class _FrequentProductsState extends State<providers> {

  /* Future  getdata() async{
    http.Response response= await http.get("http://etool.madnitextile.com/Products/prods/index");
    this.setState(() {
      FrequentProducts.mydata=jsonDecode(jsonDecode(response.body));
    });
  }*/
  @override
  void initState(){
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 170,
        width: 150,
        child: GridView.builder(
          // itemCount: mydata.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(1.0),
          primary: false,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, crossAxisSpacing: 1, mainAxisSpacing: 1,childAspectRatio: 1.1, ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return //new Card(
              // child: new Column(
              //child:
              Single_product(
                product_picture: 'images/circleavater.png',
                product_name: 'Ahmad Sibtain',
                product_name2: 'Herbalist',
                index: index,

              );

            //  ),
            // );
          },
          itemCount:  6,
        )
    );
  }
}
class Single_product extends StatefulWidget {
  final String product_name;
  final  product_picture;
  final product_name2;
  int index;


  Single_product({
    this.product_name,

    this.product_picture,
    this.product_name2,

    this.index
  });

  @override
  _Single_productState createState() => _Single_productState();
}

class _Single_productState extends State<Single_product> {
  @override
  Widget build(BuildContext context) {
    List<String> images = new List();

    return Container(
      height: 250,
      margin:EdgeInsets.symmetric(vertical: 22, horizontal: 5),

      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1.5,
        child:  Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                widget.product_picture,
                //width: 123,
                //height: 80,
                alignment: Alignment.topLeft,
                //fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child:
              Text(widget.product_name,
                style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              child:
              Text(widget.product_name2,
                style: TextStyle(fontSize: 8, color: Colors.black),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,),
            ),
          ],
        ),
      ),
    );
  }}

