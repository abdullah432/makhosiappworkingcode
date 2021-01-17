import 'package:flutter/material.dart';

class AppStatusComponents {
  static loadingContainer(Color color) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }

  static errorBody({@required message}) {
    return Container(
      child: Center(
        child: Text(message),
      ),
    );
  }
}
