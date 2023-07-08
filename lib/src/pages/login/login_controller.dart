
import 'package:flutter/material.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/users_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'dart:convert';
class loginController {

  BuildContext? context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UsersProvider  usersProvider = new UsersProvider();

  SharedPref _sharedPref = new SharedPref();


  Future <void> init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    dynamic userJson = await _sharedPref.read('user');
    if (userJson != null && userJson is Map<String, dynamic>) {
      print('Valor de userJson: $userJson');
      User user = User.fromJson(userJson);
      if (user.seccion_token != null) {
        if(user.roles.length > 1 ){
          Navigator.pushNamedAndRemoveUntil(context,'roles', (route) => false);
        }
        else{
          Navigator.pushNamedAndRemoveUntil(context,user.roles[0].route, (route) => false);
        }
      }
      print('Usuario: ${user.toJson()}');
    }
  }

  void goToRegisterPage (){
    Navigator.pushNamed(context!, "register");
  }
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    ResponseApi? responseApi = await usersProvider.login(email, password);

    if (responseApi?.success == true) {
      User user = User.fromJson(responseApi?.data);
      _sharedPref.save('user', user.toJson());

      print("User logeado: ${user.toJson()}");

      if(user.roles!.length > 1 ){
        Navigator.pushNamedAndRemoveUntil(context!,'roles', (route) => false);
      }
      else{
        Navigator.pushNamedAndRemoveUntil(context!,user.roles[0].route, (route) => false);
      }

    }else {
      MySnackbar.show(context, responseApi!.message);
    }

    print('Respuesta object:  ${responseApi}' );
    print('Respuesta: ${responseApi?.toJson()}');
    print("Email: $email");
    print("Password: $password");
  }
}