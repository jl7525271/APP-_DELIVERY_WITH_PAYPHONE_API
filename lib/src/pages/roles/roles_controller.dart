import 'package:flutter/material.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class RolesController {
   BuildContext? context;
   User user = new User();
   late Function refresh;
  SharedPref  sharedPref  = new SharedPref();


  Future <void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    //SE OBTIENE EL USUARIO DE INICIO DE SESION
    user = User.fromJson(await  sharedPref.read('user'));
    refresh();
  }

  void goToPage( String route){
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }



}