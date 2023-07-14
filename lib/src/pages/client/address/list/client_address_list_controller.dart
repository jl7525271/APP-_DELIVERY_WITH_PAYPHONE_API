import 'package:flutter/material.dart';
import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/address_provider.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientAddressListController {

  late BuildContext context;
  late Function refresh;
  List<Address> address = [];
  int radioValue = 0;

  AddressProvider _addressProvider = new AddressProvider();
  User user = new User();
  SharedPref _sharedPref = new SharedPref();

  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));

    _addressProvider.init(context, user);
    refresh();

  }

  Future <List<Address>> getAddress () async{
    address = await _addressProvider.getByUser(user.id);
    return address;
  }

  void handleRadioValueChange(int? value) {
    radioValue = value!;
    refresh();
    print('Valor seleccionado: ${radioValue}');
  }

  void goToNewAddres () {
    Navigator.pushNamed(context, 'client/address/create');
  }



}