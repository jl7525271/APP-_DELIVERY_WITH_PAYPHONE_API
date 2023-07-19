import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/orders_provider.dart';
import 'package:rent_finder/src/provider/users_provider.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class DeliveryOrdersDetailController {

  late BuildContext context;
  late Function refresh;
  Product? product;

  String? idDelivery;
  double total = 0;
  int counter = 1;
  late double productPrice = 1;
  SharedPref _sharedPref = new SharedPref();
  Order order = new Order();

  User? user;
  List<User>? users = [];
  UsersProvider _usersProvider = new UsersProvider();
  OrdersProvider _ordersProvider = new OrdersProvider();


  Future <void> init(BuildContext context, Function refresh,
      Order order) async {
    this.context = context;
    this.refresh = refresh;
    this.order = order;

    user = User.fromJson(await _sharedPref.read('user'));
    print('User: ${user.toString()}');
    _usersProvider.init(context, sesionUser: user);
    _ordersProvider.init(context, user!);

    getTotal();
    getDelivery();

    refresh();
  }

  void getTotal() {
    total = 0;
    order.products.forEach((producto) {
      total = total + (producto.price * producto.quantity!);
    });
    refresh();
  }

  void getDelivery() async {
    users = await _usersProvider.getDeliveryMen();
    refresh();
  }

  void updateOrder() async {
    refresh();
    ResponseApi? responseApi = await _ordersProvider.updateToOnTheWay(order);
    Fluttertoast.showToast(
        msg: responseApi!.message, toastLength: Toast.LENGTH_LONG);
    if(responseApi.success) {
      //ANTES DE ESTO NO HAY VALORES PARA LAT LNG
      print('Order desde detail: ${order.toJson()}');
      Navigator.pushNamed(context, 'delivery/orders/map', arguments: order!.toJson());
    }
  }

}