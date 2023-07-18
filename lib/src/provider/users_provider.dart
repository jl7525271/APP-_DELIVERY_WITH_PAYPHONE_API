import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';


class UsersProvider {
  String _url = Environment.API_DEILVERY;
  String _api = "/api/users";

  BuildContext? context;
  late User? sesionUser;

  Future <void> init(BuildContext context, {User? sesionUser})  async {
    this.context= context;
    this.sesionUser = sesionUser;
  }

  Future<User?> getById(String id) async {
    try{
      Uri url = Uri.http(_url,'$_api/findById/$id');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization': sesionUser!.seccion_token
      };
      final res = await http.get(url, headers: headers);

      if(res.statusCode == 401 ) { // NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesion expiro');
        new SharedPref().logout(context!, sesionUser!.id);
      }
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;

    }catch(e){
      print('Error $e');
      return null;
    }
  }

  Future <List<User>?> getDeliveryMen() async {
    try{
      Uri url = Uri.http(_url,'$_api/findDeliveryMen');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization': sesionUser!.seccion_token
      };
      final res = await http.get(url, headers: headers);

      if(res.statusCode == 401 ) { // NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesion expiro');
        new SharedPref().logout(context!, sesionUser!.id);
      }
      final data = json.decode(res.body);
      User user = User.fromJsonList(data);
      print('tolist: ${user.toList}');
      return user.toList;

    }catch(e){
      print('Error $e');
      return null;
    }
  }


  Future <ResponseApi?> create(User user) async{
    try {
      Uri url = Uri.http(_url,'$_api/create');
      String bodyParams = json.encode(user);
      Map <String, String> headers = {
        'Content-type':'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi  responseApi = ResponseApi.fromJson(data);
      return responseApi;

    } catch(e){
      print('Error: $e');
      return null;
    }
  }

  Future<Stream?> createWithImage(User user, File image) async {
   // print('Ruta image2: ${image} de tipo  ${image.runtimeType.toString()}');
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      //String fileName = basename(image.path);
      //print('image path: ${fileName}');
      if (image != null) {
        //print('ruta 2: ${image}');
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            filename: basename(image.path)
        ));
       }

      request.fields['user'] = json.encode(user);

      final response = await request.send(); // SE ENVIA LA PETICION
      //print('Response: ${response}');
      return response.stream.transform(utf8.decoder);

    }catch (e) {
      print('Error de: $e');
      return null;
    }
  }


  Future<Stream?> update(User user, File image) async {
    // print('Ruta image2: ${image} de tipo  ${image.runtimeType.toString()}');
    try {
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = sesionUser!.seccion_token;
      //String fileName = basename(image.path);
      //print('image path: ${fileName}');
      if (image != null) {
        //print('ruta 2: ${image}');
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            filename: basename(image.path)
        ));
      }

      request.fields['user'] = json.encode(user);

      final response = await request.send(); // SE ENVIA LA PETICION
      //print('Response: ${response}');

      if(response.statusCode == 401) {  // NO AUTORIZADO
        Fluttertoast.showToast(msg: 'Tu sesion expiro');
        new SharedPref().logout(context!, sesionUser!.id);
      }
      return response.stream.transform(utf8.decoder);

    }catch (e) {
      print('Error de: $e');
      return null;
    }
  }

  Future <ResponseApi?> logout(String idUser) async{
    try {
      Uri url = Uri.http(_url,'$_api/logout');
      String bodyParams = json.encode({
        'id' : idUser
      });
      Map <String, String> headers = {
        'Content-type':'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi  responseApi = ResponseApi.fromJson(data);
      return responseApi;

    } catch(e){
      print('Error: $e');
      return null;
    }
  }


  Future <ResponseApi?> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url,'$_api/login');
      String bodyParams = json.encode({
        'email': email,
        'password': password,
      });
      Map <String, String> headers = {
        'Content-type':'application/json'
      };
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi  responseApi = ResponseApi.fromJson(data);
      return responseApi;

    } catch(e){
      print('Error: $e');
      return null;
    }
  }

}