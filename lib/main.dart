import 'package:flutter/material.dart';
import 'package:rent_finder/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:rent_finder/src/pages/client/products/list/client_products_list_page.dart';
import 'package:rent_finder/src/pages/client/update/client_update_page.dart';
import 'package:rent_finder/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
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
        'client/products/list': (BuildContext contex) => ClientProductsListPage(),
        'client/update': (BuildContext contex) => ClientUpdatePage(),
        'restaurant/orders/list': (BuildContext contex) => RestaurantOrdersListPage(),
        'delivery/orders/list': (BuildContext contex) => DeliveryOrdersListPage(),
        'restaurant/categories/create': (BuildContext contex) => RestaurantCategoriesCreatePage(),
        'restaurant/products/create': (BuildContext contex) => RestaurantProductsCreatePage(),
        'client/orders/create': (BuildContext contex) => ClienteOrdersCreatePage(),

      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0),
        //fontFamily: "Roboto"
      ),
    );
  }
}
