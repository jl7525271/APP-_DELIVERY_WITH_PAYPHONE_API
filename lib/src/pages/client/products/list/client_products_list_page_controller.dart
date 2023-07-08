import 'package:flutter/material.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientProductsListController{
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  User user = new User();
  late Function refresh;

  GlobalKey<ScaffoldState> key = new GlobalKey <ScaffoldState>();

  Future <void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    refresh();

  }
 void  logout () {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer(){
    key.currentState?.openDrawer();
  }

  void goToRoles (){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdatePage () {
    Navigator.pushNamed(context, 'client/update');

  }

}
