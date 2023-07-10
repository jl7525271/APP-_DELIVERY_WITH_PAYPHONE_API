import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/models/category.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/pages/client/products/list/client_products_list_page_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {

  ClientProductsListController _con =  new ClientProductsListController();

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
    return DefaultTabController(
      length: _con.categories.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [
              _shoppingBag(),
            ],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 80),
                _menuDrawer(),
                SizedBox(height: 15),
                _textFielSearch(),
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length, (index) {
                return Tab(
                  child: Text(_con.categories[index].name ?? ''),
                );
            })
            ),
          ),
        ),
        drawer: _drawer(),
        body: TabBarView(
          children:_con.categories.map((RestaurantCategory category) {
            return FutureBuilder( // Listar informacion de la lista de datos. Si son varios datos
              future: _con.getProducts(category.id), //
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.70),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_,index) {
                        return _cardProduct(snapshot.data![index]);
                      }
                  );
                },
            );
          }).toList(),
        )
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      height:  240,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child:  Stack(
          children: [
            Positioned(
              top: -1.0,
              right: -1.0,
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20)
                     )
                  ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width *0.45,
                  padding: EdgeInsets.all(20),
                  child: product.image1 != null
                    ?  FadeInImage(
                    image: NetworkImage(product.image1),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'))
                    : FadeInImage(
                    image: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),)
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 25,
                  child: Text(
                      product.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'NimbusSans'
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    '${product.price ?? 0 }\$',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NimbusSans'
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _shoppingBag (){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 13),
          child: Icon(
            Icons.shopping_bag_outlined,
            color:  Colors.black,
          ),
        ),
        Positioned(
          right: 14,
            top: 15,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: Colors.green, 
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
          )
        ),
      ],
    );
  }
  
  Widget _textFielSearch (){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(Icons.search, color: Colors.grey[400],),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ), 
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey,
             ),
          ), 
          contentPadding: EdgeInsets.all(15)
        ),
      ),
    );
  }

  Widget _menuDrawer (){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer(){
    return Drawer (
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primaryColor
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                    maxLines: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      '${_con.user?.email ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    '${_con.user?.phone ?? ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 60,
                    child: _con.user?.image != null
                        ? FadeInImage(
                          placeholder: AssetImage("assets/img/no-image.png"),
                          image: NetworkImage(_con.user.image.toString()), //NetworkImage(img),
                          fit: BoxFit.contain,
                          fadeInDuration: Duration(milliseconds: 50),)

                        : Image.asset("assets/img/no-image.png", fit: BoxFit.contain),
                  ),
                ],
              )
          ),

          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          //MUESTRA ESTA OPCION EN PAGINA DEL CLIENTE SOLO SI ESTE USUARIO TIENE MAS DE UN ROL
          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_2_outlined),
          ) : Container() : Container(),

          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new_outlined),
          ),
        ],
      ),
    );
  }
  void refresh (){
    setState(() {});
  }
}