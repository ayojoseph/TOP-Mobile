
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'main.dart';

class NetworkHelper{
  NetworkHelper(this.url);
  final url;
  
  
  Future getEvents()async{
    try{
      http.Response response = await http.get(url+'/getevents');
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        return data;
      } else{
        throw 'Bad Response';
      }
    } catch(e){
      print(e);      
    }
  }

  Future getShortEvents()async{
    try{
      http.Response response = await http.get(url+'/geteventshort');
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data);
        return data;
      } else{
        throw 'Bad Response';
      }
    } catch(e){
      print(e);
    }
  }
}