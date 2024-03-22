import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api{
  static const baseUrl = "http://127.0.0.1:2000/api/";

  static adduser(Map udata) async{
    print(udata);
    var url = Uri.parse("${baseUrl}addUser");
    try{
      final res = await http.post(url, body: udata);
      if(res.statusCode == 200){
        var data = jsonDecode(res.body.toString());
        print(data);
      }else{
        print("Failed to get response");
      }
    }
    catch (e){
      debugPrint(e.toString());
    }
  }
}