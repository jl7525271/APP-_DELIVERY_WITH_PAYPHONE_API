import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientOrdersCreateController {

  late BuildContext context;
  late Function refresh;
  Product?  product;
  List <Product>? selectProducts = [];

  double total = 0;
  int counter = 1;
  late double productPrice = 1;
  SharedPref _sharedPref= new SharedPref();


  Future <void> init(BuildContext context, Function refresh) async  {
    this.context = context;
    this.refresh = refresh;

    selectProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    getTotal ();

    refresh();
  }

  void getTotal () {
    total = 0;

    selectProducts!.forEach((product) {
      total = total + (product.quantity! * product.price);
    });
    refresh();
  }

  void addItem (Product product) {
    int index = selectProducts!.indexWhere((p) => p.id == product!.id);
    selectProducts![index].quantity = selectProducts![index].quantity! +1;
    _sharedPref.save('order', selectProducts);
    getTotal();
  }

  void removeItem (Product product) {
    if( product.quantity! > 1 ) {
      int index = selectProducts!.indexWhere((p) => p.id == product!.id);
      selectProducts![index].quantity = selectProducts![index].quantity! - 1;
      _sharedPref.save('order', selectProducts);
      getTotal();
    }
  }


  void deleteItem (Product product) {
    selectProducts!.removeWhere((p) => p.id == product.id);  // Vamos a remover de la lista siempre y cuando
    // el id de ese producto sea igual al producto seleccionado
    _sharedPref.save('order', selectProducts);
    getTotal();
  }

  void goToAddress () {
    Navigator.pushNamed(context, 'client/address/list');
  }

}
