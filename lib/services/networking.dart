import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class networkHelper {
  networkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      //var longitude = jsonDecode(data)['coord']['lon'];
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print('we broke');
    }
  }
}
