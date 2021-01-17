import 'package:flutter/material.dart';
import 'app_assets.dart';

class items12 extends StatelessWidget {

  final String title, subtitle;

  const items12({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final firstList = ListTile(
        leading: Image(
          image: AssetImage('images/ic_folder_colored.png'),
        ),
        title: Text('$title',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black
          ),
        ),
        subtitle: Text('$subtitle', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey
        ),),
        trailing:
        GestureDetector(
            onTap: (){
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => InboxConversation()),);
            },child: Image(image: AssetImage('images/ic_users.png'))),

      );

    return firstList;
    }
}

class items22 extends StatelessWidget {

  final String title, subtitle;

  const items22({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final secList = ListTile(
      leading: Image(
        image: AssetImage('images/ic_folder_colored.png'),
      ),
      title: Text('$title',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black
        ),
      ),
      subtitle: Text('$subtitle', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey
      ),),

    );

    return secList;
  }
}

class items40 extends StatelessWidget {

  final String title, subtitle;

  const items40({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final thirdList = ListTile(
      leading: Image(
        image: AssetImage('images/ic_folder_colored.png'),
      ),
      title: Text('$title',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black
        ),
      ),
      subtitle: Text('$subtitle', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey
      ),),

    );

    return thirdList;
  }
}

class items6 extends StatelessWidget {

  final String title, subtitle;

  const items6({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final firstList = ListTile(
      leading: Image(
        image: AssetImage('images/ic_folder_colored.png'),
      ),
      title: Text('$title',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black
        ),
      ),
      subtitle: Text('$subtitle', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey
      ),),
      trailing:
      GestureDetector(
          onTap: (){
            // Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => InboxConversation()),);
          },child: Image(image: AssetImage('images/ic_users.png'))),

    );

    return firstList;
  }
}

class items24 extends StatelessWidget {

  final String title, subtitle;

  const items24({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final firstList = ListTile(
      leading: Image(
        image: AssetImage('images/ic_folder_colored.png'),
      ),
      title: Text('$title',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black
        ),
      ),
      subtitle: Text('$subtitle', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.grey
      ),),
      trailing:
      GestureDetector(
          onTap: (){
            // Navigator.push(context,
            //   MaterialPageRoute(builder: (context) => InboxConversation()),);
          },child: Image(image: AssetImage('images/ic_users.png'))),

    );

    return firstList;
  }
}


class notification_alert extends StatelessWidget {

  final String title;

  const notification_alert({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final notify = ListTile(
      leading: Icon(Icons.notifications_none, color: Colors.white,),
      title: Text('$title',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Poppins'
        ),
      ),
    );
    return notify;
  }
}

class HelpandFeeback extends StatelessWidget {

  final String title;

  const HelpandFeeback({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final notify = ListTile(
      leading: Icon(Icons.help_outline, color: Colors.white,),
      title: Text('$title',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Poppins'
        ),
      ),
    );
    return notify;
  }
}

class returnBtn extends StatelessWidget {

  final String title;

  const returnBtn({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final notify = ListTile(
      leading: Image(image: AssetImage('images/ic_return.png'),),
      title: Text('$title',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Poppins'
        ),
      ),
    );
    return notify;
  }
}


