import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/pages/delivery/orders/detail/delivery_orders_detail_page.dart';
import 'package:rent_finder/src/provider/orders_provider.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class DeliveryOrdersListController{
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  User user = new User();
  late Function refresh;
  List<String> status = ['DESPACHADO', 'EN CAMINO', 'ENTREGADO'];
  OrdersProvider _ordersProvider = new OrdersProvider();
  GlobalKey<ScaffoldState> key = new GlobalKey <ScaffoldState>();

  late bool? isUpdate;

  Future <void> init(BuildContext context, Function refresh ) async  {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    _ordersProvider.init(context,user);
    refresh();
  }

  Future <List<Order>> getOrders (String status) async {
    return await _ordersProvider.getByDeliveryAndStatus(user.id, status);
  }

  void openBottomSheet(Order order) async {
    isUpdate = await showMaterialModalBottomSheet(
      context: context,
      builder:(context) => DeliveryOrdersDetailPage(order:order),
    );
    if(isUpdate == true) {
      refresh();
    }
  }

  void  logout () {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer(){
    key.currentState?.openDrawer();
  }

  void goToCategoryCreate(){
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }
  void goToProductCreate (){
    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void goToRoles (){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}