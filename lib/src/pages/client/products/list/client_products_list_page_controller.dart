import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent_finder/src/models/category.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/pages/client/products/details/client_products_detail_page.dart';
import 'package:rent_finder/src/provider/categories_provider.dart';
import 'package:rent_finder/src/provider/products_provider.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientProductsListController{
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  User user = new User();
  late Function refresh;
  List<RestaurantCategory> categories = [];
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  GlobalKey<ScaffoldState> key = new GlobalKey <ScaffoldState>();


  Future <void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    _categoriesProvider.init(context,user);
    _productsProvider.init(context, user);
    getCategories ();
    refresh();
  }

  Future<List<Product>> getProducts(String id_category) async  {
    return await _productsProvider.getByCategory(id_category);
  }

 void getCategories () async {
    categories = await _categoriesProvider.getAll();
    print('categories: ${categories.length}');
    refresh();

    categories.forEach((category) {
      print('Category_id: ${category.id}');
      print('Category_name: ${category.name}');
      print('Category_description: ${category.description}');
    });
 }

 void openBottomSheet (Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) =>  ClientProductsDetailPage(product:product),
    );
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
