
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rent_finder/src/utils/shared_pref.dart';

class OrdersProvider {
  String _url = Environment.API_DEILVERY;
  String _api = '/api/orders';

  late BuildContext context;
  User? sessionUser;

  Future <void> init (BuildContext context,User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future <ResponseApi?> create(Order order) async{
    try {
      Uri url = Uri.http(_url,'$_api/create');
      String bodyParams = json.encode(order);
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser!.seccion_token
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser!.id);
      }

      final data = json.decode(res.body);
      ResponseApi  responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch(e){
      print('Error: $e');
      return null;
    }
  }

  Future <List<Order>> getByStatus(String status) async  {
    try{
      Uri url = Uri.http(_url,'$_api/findByStatus/${status}');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser!.seccion_token
      };
      final res = await http.get(url, headers: headers);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context, sessionUser!.id);
      }
      final data = json.decode(res.body);
      Order order  = Order.fromJsonList(data);
      //print('tolist: ${order.toList}');
      return order.toList;


    }catch (e){
      print('Error: $e');
      return[];
    }
  }


}