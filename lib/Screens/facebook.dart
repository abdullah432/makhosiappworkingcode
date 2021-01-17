import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:async';

class Facebook extends StatefulWidget {
  String facebook;
  Facebook(this.facebook);
  @override
  _InstagramState createState() => _InstagramState(this.facebook);
}

class _InstagramState extends State<Facebook> {
  String facebook;
  _InstagramState(this.facebook);
  InAppWebViewController _webViewController;
  String url = " ";
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(2.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(2.0),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: InAppWebView(
                  initialUrl: "${facebook}/",
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: true,
                      )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goBack();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goForward();
                    }
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.reload();
                    }
                  },
                ),
              ],
            ),
          ])),
    );
  }



}
