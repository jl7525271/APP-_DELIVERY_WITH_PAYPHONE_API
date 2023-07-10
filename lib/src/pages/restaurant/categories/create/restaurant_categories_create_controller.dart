import 'package:flutter/cupertino.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/category.dart';
import 'package:rent_finder/src/provider/categories_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:rent_finder/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';


class RestaurantCategoriesCreateController {
  late BuildContext context;
  late Function refresh;
  String? id_category ;

  List<RestaurantCategory>? categories = [];
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();


  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  late User user;
  SharedPref sharedPref = new SharedPref();



  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));

    _categoriesProvider.init(context, user);
    getCategories ();
  }
  void getCategories () async{
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void createCategory () async {
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isEmpty || description.isEmpty ) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    RestaurantCategory _category = new RestaurantCategory(
        name: name,
        description: description
    );

    ResponseApi? responseApi = await _categoriesProvider.create(_category);

    MySnackbar.show(context, responseApi!.message);


    if (responseApi!.success) {
      nameController.text = '';
      descriptionController.text= '';
      getCategories ();
      refresh();
    }

    print('Nombre de categoria: $name');
    print('Descripcion de categoria: $description');
  }



}