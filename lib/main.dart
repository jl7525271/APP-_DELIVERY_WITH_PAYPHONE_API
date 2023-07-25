import 'package:flutter/material.dart';
import 'package:rent_finder/src/pages/client/address/create/client_address_create_page.dart';
import 'package:rent_finder/src/pages/client/address/list/client_address_list_page.dart';
import 'package:rent_finder/src/pages/client/address/map/client_address_map_page.dart';
import 'package:rent_finder/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:rent_finder/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:rent_finder/src/pages/client/orders/map/client_orders_map_page.dart';
import 'package:rent_finder/src/pages/client/payments/create/client_payments_create_page.dart';
import 'package:rent_finder/src/pages/client/products/list/client_products_list_page.dart';
import 'package:rent_finder/src/pages/client/update/client_update_page.dart';
import 'package:rent_finder/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:rent_finder/src/pages/delivery/orders/map/delivery_orders_map_page.dart';
import 'package:rent_finder/src/pages/login/login_page.dart';
import 'package:rent_finder/src/pages/register/register_page.dart';
import 'package:rent_finder/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:rent_finder/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:rent_finder/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:rent_finder/src/pages/roles/roles_page.dart';
import 'package:rent_finder/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RentFinder",
      initialRoute: "login",
      routes: {
        'login': (BuildContext contex) => LoginPage(),
        'register': (BuildContext contex) => RegisterPage(),
        'roles' : (BuildContext contex) => RolesPage(),
        'client/orders/create': (BuildContext contex) => ClienteOrdersCreatePage(),
        'client/orders/list': (BuildContext contex) => ClientOrdersListPage(),
        'client/orders/map': (BuildContext contex) => ClientOrdersMapPage(),
        'client/products/list': (BuildContext contex) => ClientProductsListPage(),
        'client/payments/create': (BuildContext contex) => ClientPaymentsCreatePage(),
        'client/update': (BuildContext contex) => ClientUpdatePage(),
        'client/address/create': (BuildContext contex) => ClientAddressCreatePage(),
        'client/address/list': (BuildContext contex) => ClientAddressListPage(),
        'client/address/map': (BuildContext contex) => ClientAddressMapPage(),
        'restaurant/categories/create': (BuildContext contex) => RestaurantCategoriesCreatePage(),
        'restaurant/products/create': (BuildContext contex) => RestaurantProductsCreatePage(),
        'restaurant/orders/list': (BuildContext contex) => RestaurantOrdersListPage(),
        'delivery/orders/list': (BuildContext contex) => DeliveryOrdersListPage(),
        'delivery/orders/map': (BuildContext contex) => DeliveryOrdersMapPage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0),
        //fontFamily: "Roboto"
      ),
    );
  }
}
