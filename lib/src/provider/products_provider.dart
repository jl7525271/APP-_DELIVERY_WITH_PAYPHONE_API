import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/category.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rent_finder/src/utils/shared_pref.dart';

class ProductsProvider {

  String _url = Environment.API_DEILVERY;
  String _api = '/api/products';

  late BuildContext? context;
  User sessionUser = User();

  Future <void> init (BuildContext context,User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }


  Future <List<Product>> getByCategory( String id_category) async  {
    try{
      Uri url = Uri.http(_url,'$_api/findByCategory/$id_category');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser.seccion_token
      };
      final res = await http.get(url, headers: headers);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context!, sessionUser.id);
      }
      final data = json.decode(res.body);
      Product product = Product.fromJsonList(data);
      return product.toList;

    }catch (e){
      print('Error: $e');
      return[];
    }
  }

  Future <List<Product>> getByCategoryAndProductName( String id_category, String productName) async  {
    try{
      Uri url = Uri.http(_url,'$_api/findByCategoryAndProductName/$id_category/$productName');
      Map <String, String> headers = {
        'Content-type':'application/json',
        'Authorization' : sessionUser.seccion_token
      };
      final res = await http.get(url, headers: headers);
      if(res.statusCode == 401 ) {
        Fluttertoast.showToast(msg: 'Session expirada');
        new SharedPref().logout(context!, sessionUser.id);
      }
      final data = json.decode(res.body);
      Product product = Product.fromJsonList(data);
      return product.toList;

    }catch (e){
      print('Error: $e');
      return[];
    }
  }

  Future<Stream?> create(Product product, List<File> images) async {
    // print('Ruta image2: ${image} de tipo  ${image.runtimeType.toString()}');
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization']= sessionUser.seccion_token;

      //String fileName = basename(image.path);
      //print('image path: ${fileName}');
      for (int i = 0; i<images.length; i++ ) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }
      request.fields['product'] = json.encode(product);

      final response = await request.send(); // SE ENVIA LA PETICION
      print('Response: ${response}');
      return response.stream.transform(utf8.decoder);

    }catch (e) {
      print('Error de: $e');
      return null;
    }
  }

}