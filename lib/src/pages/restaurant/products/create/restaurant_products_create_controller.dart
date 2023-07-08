import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/category.dart';
import 'package:rent_finder/src/provider/categories_provider.dart';
import 'package:rent_finder/src/provider/products_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RestaurantProductsCreateController {
  late BuildContext context;
  late Function refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();

  late User user;
  SharedPref sharedPref = new SharedPref();
  List<RestaurantCategory>? categories = [];
  String? id_category ;

  final  ImagePicker _pickedFile = new ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  late ProgressDialog _progressDialog;

  Future <void> init (BuildContext context, Function refresh ) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    _progressDialog = new ProgressDialog(context: context);

    getCategories ();
  }

  void getCategories () async{
    categories = await _categoriesProvider.getAll();
    String priceInString = priceController.text;

    print('precio: ${priceInString}');
    refresh();
  }
  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    String priceInString = priceController.text;

    if(name.isEmpty || description.isEmpty  || priceInString.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if(imageFile1 == null || imageFile2 == null || imageFile3 == null ) {
      MySnackbar.show(context, 'Seleccionar tres imagenes');
      return;
    }

    if(id_category== null) {
      MySnackbar.show(context, 'Selecciona la categoria del producto');
      return;
    }

    Product product = new Product(

      name: name,
      description: description,
      price: double.parse(priceInString),
      id_category: int.parse(id_category!)
    );

    List <File> images = [];
    images.add(imageFile1!);
    images.add(imageFile2!);
    images.add(imageFile3!);

    _progressDialog.show(max: 100, msg: 'Espere un momento');
    Stream? stream = await _productsProvider.create(product,images);
    stream!.listen((res) {
      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message);

      if(responseApi.success){
        resetValues();
      }
    });
    print('Formulario de producto: ${product.toJson()}');
  }

  void resetValues (){
    nameController.text= '';
    descriptionController.text = '';
    priceController.text = '0.00';
    imageFile1= null;
    imageFile2= null;
    imageFile3= null;
    id_category = null;

    refresh();
  }

  Future <void> selectImage(ImageSource imageSource, int numberFile) async {
    final XFile? pickedFile = await _pickedFile.pickImage(source:imageSource);
    if (pickedFile !=  null ) {
      if(numberFile==1 ){
        imageFile1 =  File(pickedFile.path.toString());
      }else if (numberFile==2 ){
        imageFile2 =  File(pickedFile.path.toString());
      } else if (numberFile==3 ){
        imageFile3 =  File(pickedFile.path.toString());
      }
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile){
    Widget galleryButton = ElevatedButton(
        onPressed:(){
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text('Galeria')
    );

    Widget cameraButton = ElevatedButton(
        onPressed:(){
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text('Camara')
    );

    AlertDialog  alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );

    showDialog(context: context!, builder: (BuildContext context ){
      return alertDialog;
    },);

  }
}