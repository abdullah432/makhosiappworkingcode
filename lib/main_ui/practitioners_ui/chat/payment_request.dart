import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_keys.dart';

class PaymentRequest extends StatefulWidget {
  final String sender, reciever;

  PaymentRequest({this.sender, this.reciever});
  @override
  _PaymentRequestState createState() => _PaymentRequestState();
}

class _PaymentRequestState extends State<PaymentRequest> {
  bool consultations = false;
  bool goods = false;

  Map sender, reciever;
  TextEditingController _remark = TextEditingController(text: '');
  TextEditingController _amountToReq = TextEditingController();

  @override
  initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    var senderDoc = await FirebaseFirestore.instance
        .collection(AppKeys.PRACTITIONERS)
        .doc(widget.sender)
        .get();
    var recieverDoc = await FirebaseFirestore.instance
        .collection('patients')
        .doc(widget.reciever)
        .get();

    setState(() {
      sender = senderDoc.data();
      reciever = recieverDoc.data();
    });
  }

  Future<void> _sendPaymentRequest() async {
    //First we will update inbox data for patient i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.sender)
        .collection('inbox')
        .doc(widget.reciever)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': 'Payment request of ${_amountToReq.text}',
        'seen': true,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to patient section
    var senderMsg = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.sender)
        .collection('inbox')
        .doc(widget.reciever)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': 'Payment request of ${_amountToReq.text}',
        'is_received': false,
        'amount': _amountToReq.text,
        'type': 'payment_request',
        'paid': false
      },
    );
    //Now we will update inbox data for practitioner i.e last message, seen and timestamp
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.reciever)
        .collection('inbox')
        .doc(widget.sender)
        .set(
      {
        'timestamp': Timestamp.now(),
        'last_message': 'Payment request of ${_amountToReq.text}',
        'seen': false,
      },
      SetOptions(
        merge: true,
      ),
    );
    //Now we will add message to practitioner section
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.reciever)
        .collection('inbox')
        .doc(widget.sender)
        .collection('messages')
        .add(
      {
        'timestamp': Timestamp.now(),
        'message': 'Payment request of ${_amountToReq.text}',
        'is_received': true,
        'amount': _amountToReq.text,
        'type': 'payment_request',
        'paid': false,
        'message_ref': senderMsg.id
      },
    );
    _amountToReq.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Payment Request',
          style: TextStyle(color: AppColors.COLOR_PRIMARY),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('images/circleavater.png')),
                CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('images/circleavater.png')),
              ],
            ),
            Text(
              reciever == null ? '' : reciever['full_name'],
              style: TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 18),
            ),
            Text(
              'Payment to ${sender == null ? '' : sender['first_name']}',
              style: TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'R',
                  style:
                      TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 30),
                ),
                Container(
                  height: 60,
                  width: 100,
                  child: TextField(
                    controller: _amountToReq,
                    style:
                        TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 30),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '0.00'),
                  ),
                ),
                Text(
                  'ZAR',
                  style:
                      TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 16),
                ),
              ],
            ),
            Container(
              width: 180,
              height: 63,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey[100],
              ),
              child: TextField(
                controller: _remark,
                decoration: InputDecoration(
                    fillColor: AppColors.COLOR_LIGHTSKY,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Remarks"),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Types of Payment',
              style: TextStyle(color: AppColors.COLOR_PRIMARY, fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      color: AppColors.COLOR_PRIMARY,
                      size: 40,
                    ),
                    title: Text(
                      'Consultations',
                      style: TextStyle(
                          color: AppColors.COLOR_PRIMARY, fontSize: 16),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'These are charges for any consultation session that might have been carried out',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 11),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Visibility(
                            visible: consultations,
                            child: Icon(
                              Icons.done,
                              color: AppColors.COLOR_PRIMARY,
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        consultations = !consultations;
                      });
                    },
                  ),
                  Divider(color: Colors.blueGrey),
                  ListTile(
                    leading: Icon(
                      Icons.shop,
                      color: AppColors.COLOR_PRIMARY,
                      size: 40,
                    ),
                    title: Text(
                      'Good and Services',
                      style: TextStyle(
                          color: AppColors.COLOR_PRIMARY, fontSize: 16),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Buying something? Any goods or even additional services which do not include consultations',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 11),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Visibility(
                            visible: goods,
                            child: Icon(
                              Icons.done,
                              color: AppColors.COLOR_PRIMARY,
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        goods = !goods;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'More about. ',
                  style: TextStyle(color: Color(0XFF222222), fontSize: 14),
                ),
                Text(
                  'Mkhosi Community Guidelines',
                  style: TextStyle(color: Color(0XFF222222), fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: AppColors.COLOR_PRIMARY,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Text(
                        'Send Payment Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _sendPaymentRequest();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
