import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:rent_finder/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';

import '../../../../models/category.dart';


class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({super.key});

  @override
  State<RestaurantProductsCreatePage> createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {

  RestaurantProductsCreateController _con = new RestaurantProductsCreateController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text("Nueva producto"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          _textFielName(),
          _textFielDescription(),
          _textFielPrice(),

          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3),
              ],
            ),
          ),
          _dropDownCategories(_con.categories!),
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _textFielName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
          hintText: "Nombre del producto",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.local_pizza, color: MyColors.primaryColor),
        ),
      ),
    );
  }


  Widget _textFielPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "Precio",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          prefixText: "\$", // Agrega el símbolo del dólar como prefijo
          prefixStyle: TextStyle(
            color: Colors.black,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.monetization_on, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _dropDownCategories ( List<RestaurantCategory> categories) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    elevation: 0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(
                      Icons.search,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                      'Categoria',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                      'Selecciona categoria',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  items: _dropDrownItems(categories),
                  value: _con.id_category,
                  onChanged:(value){
                    setState(() {
                      print('Categoria seleccionada: $value');
                      _con.id_category = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  List<DropdownMenuItem<String>> _dropDrownItems(List<RestaurantCategory> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          child: Text(category.name),
          value: category.id,

      ));
    });
    return list;
  }

  Widget _textFielDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
          hintText: "Descripcion del producto",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(Icons.list_alt, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _cardImage (File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ?  Card(
                elevation: 3.0,
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width*0.26,
                  child: Image.file(
                      imageFile,
                      fit:BoxFit.cover)))
          : Card(
                elevation: 3.0,
                child: Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width*0.26,
                  child: Image(
                      image:AssetImage('assets/img/add_image.png'),
                      fit:BoxFit.cover))),
    );
  }


  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed:_con.createProduct,
        child: Text("Crear producto"),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh(){
    setState(() {});
  }



}
