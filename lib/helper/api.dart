import 'dart:convert';

import 'package:http/http.dart' as http;

import '../podo/category.dart';

class Api {
  static String baseURL = "http://mkhosi-ehub.com/";
  static String popular = baseURL + "api.php?get=top";
  static String breaking = baseURL + "api.php?get=breaking";
  static String trends = baseURL + "api.php?get=trends";
  static String searchUrl = baseURL + "api.php?get=search&char=";
  static String imageURL = baseURL + "images/";

  static Future<CategoryFeed> getNews(String url) async {
    var res = await http.get(url);
    CategoryFeed category;
    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      category = CategoryFeed.fromJson(jsonResponse);
    } else {
      throw ("Error ${res.statusCode}");
    }
    return category;
  }

  static Future<bool> updateCount(String url) async {
    var res = await http.get(url);
    if (res.statusCode == 200) {
    } else {
      throw ("Error ${res.statusCode}");
    }
    return true;
  }

  static Future<String> getTokenForAgora(String channelName) async {
    var body = jsonEncode({'channelName': channelName});

    var header = {'Content-Type': 'application/json'};
    var res = await http.post('http://bc4616890440.ngrok.io',
        headers: header, body: body);

    if (res.statusCode == 200) {
      final jsonResponse = json.decode(res.body);
      return jsonResponse['tokenA'];
    } else {
      return "";
    }
  }
}
