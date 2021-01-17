import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final link;
  final title;
  WebViewPage({
    @required this.link,
    @required this.title,
  });
  @override
  _WebViewPageState createState() => _WebViewPageState(
        link: link,
        title: title,
      );
}

class _WebViewPageState extends State<WebViewPage> {
  String link;
  String title;
  _WebViewPageState({
    this.link,
    this.title,
  });
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return errorMsg != ''
            ? Text(
                errorMsg,
                style: TextStyle(color: Colors.black),
              )
            : (link == ''
                ? Center(child: CircularProgressIndicator())
                : WebView(
                    initialUrl: link,
                    javascriptMode: JavascriptMode.unrestricted,
                  ));
      }),
    );
  }
}
