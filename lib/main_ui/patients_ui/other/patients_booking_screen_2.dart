import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/contracts/i_info_dialog_clicked.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:makhosi_app/utils/app_toast.dart';
import 'package:makhosi_app/utils/others.dart';

class PatientBookingFinal extends StatefulWidget {
  final email;
  final mobile;
  final forSomeoneElse;
  final selectionDescription;
  final name;
  final time;
  final date;
  final practitioner;
  final consultationFee;

  PatientBookingFinal(
      {this.email,
      this.name,
      this.time,
      this.mobile,
      this.forSomeoneElse,
      this.selectionDescription,
      this.date,
      this.practitioner,
      this.consultationFee});
  @override
  _PatientBookingFinalState createState() => _PatientBookingFinalState();
}

class _PatientBookingFinalState extends State<PatientBookingFinal>
    implements IInfoDialogClicked, IRoundedButtonClicked {
  TextEditingController _noteText = TextEditingController(text: '');
  bool _invoiceRequired = false;
  bool _sickNoteRequired = false;

  Widget _getLabelText(label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getLabelTextLight(label) {
    return Text(
      label,
      style: TextStyle(
          fontSize: 16,
          color: AppColors.COLOR_LIGHTBLUE,
          fontWeight: FontWeight.w500),
    );
  }

  Widget _covidCheckItem() {
    return TextField(
      controller: _noteText,
      decoration: InputDecoration(
        fillColor: AppColors.COLOR_LIGHTSKY,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.COLOR_SKYBORDER),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _invoiceCheckItem(
    String labelName1,
    String labelName2,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 7,
            color: Colors.grey[100],
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Checkbox(
                value: _invoiceRequired,
                onChanged: (val) {
                  setState(() {
                    _invoiceRequired = val;
                  });
                }),
          ),
          Expanded(flex: 4, child: _getLabelTextLight(labelName1)),
          Expanded(flex: 2, child: _getLabelTextLight(labelName2)),
        ],
      ),
    );
  }

  Widget _sickNoteCheckItem(
    String labelName1,
    String labelName2,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 7,
            color: Colors.grey[100],
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Checkbox(
                value: _sickNoteRequired,
                onChanged: (val) {
                  setState(() {
                    _sickNoteRequired = val;
                  });
                }),
          ),
          Expanded(flex: 4, child: _getLabelTextLight(labelName1)),
          Expanded(flex: 2, child: _getLabelTextLight(labelName2)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 200.0,
              backgroundColor: Colors.transparent,
              floating: false,
              snap: false,
              pinned: false,
              centerTitle: true,
              flexibleSpace: Container(
                child: Image.asset(
                  'images/booking_pg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                color: Colors.white24,
                padding: EdgeInsets.all(8),
                iconSize: 20,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[]),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            'Good day, thank you for booking an appointment. I hope '
                            'that I will be of assistance in whichever way I can.'
                            'Before our appointment date,. Please indicate if you would '
                            'like additional items',
                        style: TextStyle(color: AppColors.COLOR_INSTEXT),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _getLabelText(
                        'Add Note for Service Provider (if you have):'),
                    SizedBox(
                      height: 15,
                    ),
                    _covidCheckItem(),
                    SizedBox(
                      height: 20,
                    ),
                    _getLabelText('Please select more option if necessary:'),
                    SizedBox(
                      height: 15,
                    ),
                    _invoiceCheckItem('Invoice required', '+R0'),
                    SizedBox(
                      height: 20,
                    ),
                    _sickNoteCheckItem('Sick note required', '+R7.50'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      child: Text(
                        '*Sick notes are only avialble for those requiring the services'
                        'of Traditional Healers/Abelaphis. Additional fees will apply, '
                        'please consult your Healer to find out more.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppButtons.getRoundedButton(
                      context: context,
                      iRoundedButtonClicked: this,
                      label: 'FINISH',
                      clickType: ClickType.DUMMY,
                    )
                  ],
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }

  @override
  onClick(ClickType clickType) {
    if (widget.time != null) {
      Others.showInfoDialog(
        context: context,
        title: 'Booking Confirmation!',
        message:
            'Are you sure you want to make appointment on ${widget.selectionDescription}?',
        positiveButtonLabel: 'Confirm',
        negativeButtonLabel: 'Cancel',
        iInfoDialogClicked: this,
        isInfo: false,
      );
    } else {
      Others.showInfoDialog(
        context: context,
        title: 'Error!',
        message: 'Please select booking date and time first',
        positiveButtonLabel: null,
        negativeButtonLabel: 'Close',
        iInfoDialogClicked: this,
        isInfo: true,
      );
    }
  }

  @override
  void onNegativeClicked() {
    Navigator.pop(context);
  }

  @override
  void onPositiveClicked() async {
    Navigator.pop(context);
    try {
      var data = {
        'appointment_start_hour': widget.time,
        'appointment_date': widget.date,
        'appointment_by': FirebaseAuth.instance.currentUser.uid,
        'appointment_to': widget.practitioner,
        'for_someone_else': widget.forSomeoneElse,
        'email': widget.email,
        'mobile': widget.mobile,
        'note': _noteText.text,
        'invoice_required': _invoiceRequired,
        'sicknote_required': _sickNoteRequired
      };
      await FirebaseFirestore.instance.collection('bookings').add(data);
      Navigator.pop(context);
      Navigator.pop(context);
      AppToast.showToast(message: 'Appointment successfully made');
    } catch (exc) {
      AppToast.showToast(message: 'Error booking practitioner');
    }
  }
}
