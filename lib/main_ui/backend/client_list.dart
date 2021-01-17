import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {

  List invoiceTo=[];

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client\'s List'),
      ),
      body: (invoiceTo.length==0)?Center(child: CircularProgressIndicator(),):ListView.builder(
          shrinkWrap: true,
          itemCount: invoiceTo.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.of(context).pop(
                    ClientDetails(
                      name: invoiceTo[index]['full_name'],
                      email: invoiceTo[index]['email']
                ));
              },
              child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(invoiceTo[index]['full_name'],),
                  )),
            );
          }),
    );
  }

  getData()async{

    try{
    String uid = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('chats').doc(uid).collection('inbox').get().then(
            (value) {
              if(value!=null){
              value.docs.forEach((element) async{

          await FirebaseFirestore.instance.collection('patients').doc(element.id).get().then((value) {
            setState(() {
              invoiceTo.add(value.data());
            });
          }
          );
        }
        );
              }
            }
    );
  } catch(e){
      print(e);
    }
  }
  }

class ClientDetails {
  final String name;
  final String email;
  //
  ClientDetails({this.name,this.email});
}
