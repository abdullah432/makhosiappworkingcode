import 'package:flutter/material.dart';
//import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:provider/provider.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makhosi_app/contracts/i_rounded_button_clicked.dart';
import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/main_ui/patients_ui/home/patient_home.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/home/practitioners_home.dart';
import 'package:makhosi_app/providers/notificaton.dart';
import 'package:makhosi_app/ui_components/app_buttons.dart';
import 'package:makhosi_app/utils/navigation_controller.dart';
import 'package:makhosi_app/utils/others.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/traditional_healers_screenone.dart';
import 'package:makhosi_app/main_ui/practitioners_ui/auth/traditional_healers_updated_screens/tradional_healer_register_screen_main.dart';
import 'package:provider/provider.dart';
import 'package:makhosi_app/main_ui/payment_ui/subscription_payment.dart';
class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions>implements IRoundedButtonClicked {
  String serviceAll =
      "Virtual Reception\nSmart Booking Calendar\nStore Listing\nMkhosi Knowladge Hub\nIn-App VIdeo and voice calling\nGenarate summary booking reports\n";
  String startUp =
      "Automatic appointment reminder\n1 month of virtual Business Coaching (4 Sessions)\n%GB Server Space\n50% discount on Mkhosi Business Networking";
  String setUp =
      "Generate Invoices\nGenerate Financial Records and Reports\nDigital CLient Records\nCustomable Calendar\n3  month of virtual Business Coaching (8 Sessions)\n15GB Server Space\n75% discount on Mkhosi Business Networking";
  String shine =
      "Generate Invoices\nGenerate Financial Records and Reports\nDigital CLient Records\nCustomable Calendar\nClient Database\nOwn Website\nAdvertising on Mkhosi Website\nBusiness Expansion and fundraising support\n6 month of virtual Business Coaching (12 Sessions)\nUnlimited Server Space\nFree access to Mkhosi Business Networking";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Mkhosi Subscription",
            style: TextStyle(fontSize: 30),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                package(
                    200, "START-UP PACKAGE", serviceAll + startUp, Colors.teal),
                package(450, "SET-UP PACKAGE", serviceAll + setUp,
                    Colors.blueGrey[800]),
                package(850, "SHINE PACKAGE", serviceAll + shine,
                    Colors.brown[600]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget package(int price, String packageName, String services, Color cl) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.80,
        width: MediaQuery.of(context).size.width * 0.90,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.90,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  color: cl,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          packageName,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Column(
                          children: [
                            Text(
                              "          ZAR",
                              style:
                                  TextStyle(fontSize: 28, color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              price.toString(),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              services,
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Text(
                          "No Hidden Costs",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:  AppButtons.getRoundedButton(
                context: context,
                iRoundedButtonClicked: this,
                label: 'Choose Plan',
                clickType: ClickType.PRACTITIONER,
              ),/* RaisedButton(
                color: Colors.white,
                onPressed: () {
                  NavigationController.pushReplacement(context, PractitionersHome());
                   Provider<NotificationProvider>(
                      create: (context) {
                        NotificationProvider notificationProvider =
                        NotificationProvider();
                        notificationProvider.firebaseMessaging.subscribeToTopic(
                            'messages_${FirebaseAuth.instance.currentUser.uid}');
                        return notificationProvider;
                      },
                      child: PractitionersHome());
                  //payNow(price);
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Choose Plan",
                    style: TextStyle(letterSpacing: 2, fontSize: 20),
                  ),
                ),
              ),*/
            )
          ],
        ),
      ),
    );
  }

 String clientNonce =
      "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";


  String nnc="dsd";
  payNow(int price) async {
    BraintreePayment braintreePayment = new BraintreePayment();
    var data = await braintreePayment.showDropIn(
        nonce: clientNonce, amount:price.toString(), nameRequired:true);
    print("Response of the payment $data");
  }
  @override
  onClick(ClickType clickType) {
    Object targetScreen;
    switch (clickType) {
      case ClickType.PATIENT:
        targetScreen = Provider<NotificationProvider>(
            create: (context) {
              NotificationProvider notificationProvider =
              NotificationProvider();
              notificationProvider.firebaseMessaging.subscribeToTopic(
                  'messages_${FirebaseAuth.instance.currentUser.uid}');
              return notificationProvider;
            },
            child: PatientHome());
        break;
      case ClickType.PRACTITIONER:
        targetScreen = Provider<NotificationProvider>(
            create: (context) {
              NotificationProvider notificationProvider =
              NotificationProvider();
              notificationProvider.firebaseMessaging.subscribeToTopic(
                  'messages_${FirebaseAuth.instance.currentUser.uid}');
              return notificationProvider;
            },
            child: PractitionersHome());
        break;
      case ClickType.LOGIN:
        break;
      case ClickType.DUMMY:
        break;
    }
      NavigationController.pushReplacement(context, targetScreen);
}
}