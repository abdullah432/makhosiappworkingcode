import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> reportUser(
    String serviceProviderName,
    String complainTxt,
    String reportedBy,
    String userType,
  ) async {
    try {
      await db.collection("reports").add({
        'userType': userType,
        'serviceProviderName': serviceProviderName,
        'complain': complainTxt,
        'reportedBy': reportedBy,
        'date': DateTime.now(),
      });

      return true;
    } catch (e) {
      print('exception during adding service: ' + e.toString());
      return false;
    }
  }

  Future<bool> reportIssue(
    String complainTxt,
  ) async {
    try {
      await db.collection("userfeedbacks").add({
        'complain': complainTxt,
        'reportedBy': getCurrentUserID(),
        'date': DateTime.now(),
      });

      return true;
    } catch (e) {
      print('exception during adding service: ' + e.toString());
      return false;
    }
  }

  Future<bool> updateBankingDetail({
    @required accountNumber,
    @required bankName,
    @required branchCode,
    @required accountHolder,
    @required updateCostPerSession,
    @required currency,
    @required bool acceptCash,
    @required bool acceptOnline,
  }) async {
    try {
      await db.collection("paymentinfo").doc(getCurrentUserID()).set({
        'accountnumber': accountNumber,
        'bankname': bankName,
        'branchcode': branchCode,
        'accountholder': accountHolder,
        'updatecostpersession': updateCostPerSession,
        'currency': currency,
        'acceptCash': acceptCash,
        'acceptOnline': acceptOnline,
        'date': DateTime.now(),
      });

      return true;
    } catch (e) {
      print('exception during adding service: ' + e.toString());
      return false;
    }
  }

  Future<Uri> setInvitationToFriend() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://makhosiapp.page.link',
      link: Uri.parse('https://makhosiapp.page.link/helloworld'),
      androidParameters: AndroidParameters(
        packageName: 'com.squadtechs.markhor.makhosi_app',
        minimumVersion: 21,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.squadtechs.markhor.makhosi_app',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
      // googleAnalyticsParameters: GoogleAnalyticsParameters(
      //   campaign: 'example-promo',
      //   medium: 'social',
      //   source: 'orkut',
      // ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl;
  }

  Future<bool> sendEmailToUser(name, link, email) async {
    final MailOptions mailOptions = MailOptions(
      body:
          // '$name send you invitation link to install Makhosi App. Here is the link. $link',
          '''Good day,

We are excited to bring you the Mkhosi a mobile application created for service providers to manage and operate their businesses. One of its primary objectives is to increase business efficiency by providing tools for different small business owners to optimise their operations thereby increasing their profitability. Mkhosi creates a platform for all businesses to receive exposure and be marketed on the Mkhosi Community where existing and potential clients will be able to access service providers of their choice.

The vision for Mkhosi is built on connecting communities and growing small businesses. The mobile app is currently available on all app stores.

To find out more please visit our website: www.mkhosi.com

Or connect with us on all social media @Mkhosi

Alternatively you can also send an email to our adminstration support team, and one of our team members will be in touch. Contact details are: info@mkhosi.com

Kind regards,

Mkhosi Team''',
      subject: 'the Email Subject',
      recipients: [email],
      isHTML: true,
      // bccRecipients: ['other@example.com'],
      // ccRecipients: ['third@example.com'],
      // attachments: [
      //   'path/to/image.png',
      // ],
    );

    final MailerResponse response = await FlutterMailer.send(mailOptions);
    print(response.toString());
    return true;
    // switch (response) {
    //   case MailerResponse.saved:

    //     /// ios only
    //     platformResponse = 'mail was saved to draft';
    //     break;
    //   case MailerResponse.sent:

    //     /// ios only
    //     platformResponse = 'mail was sent';
    //     break;
    //   case MailerResponse.cancelled:

    //     /// ios only
    //     platformResponse = 'mail was cancelled';
    //     break;
    //   case MailerResponse.android:
    //     platformResponse = 'intent was successful';
    //     break;
    //   default:
    //     platformResponse = 'unknown';
    //     break;
    // }
  }

  getCurrentUserID() {
    User user = auth.currentUser;
    return user.uid;
  }

  getCurrentUserName() {
    return auth.currentUser.displayName;
  }
}
