import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rent_finder/src/utils/shared_pref.dart';

class AddressProvider {

  String _url = Environment.API_DEILVERY;
  String _api = '/api/address';

  late BuildContext? context;
  User sessionUser = new User();

  Future <void> init (BuildContext context,User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future <List<Address>> getByUser(String idUser) async  {
    try{
      Uri url = Uri.http(_url,'$_api/findByUser/${idUser}');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser.seccion_token
      };
      final res = await http.get(url, headers: headers);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context!, sessionUser!.id);
      }
      final data = json.decode(res.body);
      Address address = Address.fromJsonList(data);
      print('address:${address.toList}');
      return address.toList;

    }catch (e){
      print('Error: $e');
      return[];
    }
  }


  Future <ResponseApi?> create(Address address) async{
    try {
      Uri url = Uri.http(_url,'$_api/create');
      String bodyParams = json.encode(address);
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser!.seccion_token
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context!, sessionUser!.id);
      }

      final data = json.decode(res.body);
      ResponseApi  responseApi = ResponseApi.fromJson(data);
      return responseApi;

    } catch(e){
      print('Error: $e');
      return null;
    }
  }

}