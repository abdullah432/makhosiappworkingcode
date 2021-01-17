import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/Assets/app_assets.dart';
import 'package:makhosi_app/Screens/account_screen.dart';
import 'package:makhosi_app/Screens/clients_records.dart';
import 'package:makhosi_app/Screens/mypersonal_drive.dart';
import 'package:makhosi_app/Screens/notification_screen.dart';
import 'package:makhosi_app/Screens/summary_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {

  int _pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final List<Widget> _bottomNavChilds = [
      ClientRecords(),
      MyPersonalStorage(),
      AccountsScreen(),
      SummaryScreen(),
      NotificationScreen(),

    ];

    //BottomNavigationBar
    CurvedNavigationBar bottomNav = new CurvedNavigationBar(key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.folder_outlined, size: 30, color: Colors.white,),
        Icon(Icons.data_usage, size: 30,  color: Colors.white,),
        Icon(Icons.account_balance_outlined, size: 25,  color: Colors.white,),
        Icon(Icons.legend_toggle, size: 30,  color: Colors.white,),
        Icon(Icons.notifications_none, size: 30,  color: Colors.white,),
      ],
      color: AppColors.themecolor,
      buttonBackgroundColor: AppColors.themecolor,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInBack,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _pageIndex = index;
        });
      },
    );

    return Scaffold(
      bottomNavigationBar: bottomNav,
      body: _bottomNavChilds[_pageIndex],
    );
  }
}