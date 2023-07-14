import 'package:flutter/material.dart';

class ClientAddressListController {

  late BuildContext context;
  late Function refresh;

  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

  }

  void goToNewAddres () {
    Navigator.pushNamed(context, 'client/address/create');
  }



}