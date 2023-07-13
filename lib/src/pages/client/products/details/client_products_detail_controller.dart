import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientProductsDetailController {

  late BuildContext context;
  late Function refresh;
  Product?  product;
  List <Product>? selectProducts = [];


  int counter = 1;
  late double productPrice = 1;
  SharedPref _sharedPref= new SharedPref();


  Future <void> init(BuildContext context, Function refresh, Product product) async  {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;

    //_sharedPref.remove('order');
    selectProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    print('selectProducts ${selectProducts}');
    selectProducts?.forEach((p) {
      print('Producto seleccionado: ${p.toJson()}');
    });
    refresh();
  }

  void addItem () {
    counter = counter + 1;
    productPrice = product!.price * counter;
    product!.quantity =  counter;

    refresh ();
  }


  void addToBag() {
    int index = selectProducts!.indexWhere((p) => p.id == product!.id);
    print('Index: $index');
     if (index == -1 ) { // aun no hay ese producto dentro de la lista
       if(product!.quantity  == null || product!.quantity  == 0 ) {
          product!.quantity = 1;
       }
       selectProducts?.add(product!);
     } else {
       selectProducts?.forEach((p) {
         print('Producto del else seleccionado: ${p.toJson()}');
       });
       selectProducts![index].quantity = selectProducts![index].quantity! + counter;
       print(counter);
     }

    _sharedPref.save('order', selectProducts);
    Fluttertoast.showToast(msg: 'Producto agregado al carrito');
  }



  void removeItem () {
    if (counter > 1 ) {
      counter = counter - 1;
      productPrice = product!.price * counter;
      product!.quantity = counter;
      refresh();
    }
  }


}
