import 'package:flutter/material.dart';
import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/address_provider.dart';
import 'package:rent_finder/src/provider/orders_provider.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientAddressListController {

  late BuildContext context;
  late Function refresh;
  List<Address> address = [];
  int radioValue = 0;


  AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref _sharedPref = new SharedPref();
  OrdersProvider _ordersProvider = new OrdersProvider();


  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    _addressProvider.init(context, user!);
    _ordersProvider.init(context, user!);

    refresh();

  }

  Future <List<Address>> getAddress () async{
    print('User id: ${user!.id}');
    address = await _addressProvider.getByUser(user!.id);
    Address a = Address.fromJson( await _sharedPref.read('address') ?? {}); // obtenie la direccion guardad en cache
    //print('Se guardo la ubicacion: ${a.toJson()}');
    int index = address.indexWhere((ad) => ad.id == a.id );
    if(index != -1 ) {
      radioValue = index;
    }
    //print('Valor seleccionado: ${radioValue}');
    return address;
  }



  void handleRadioValueChange(int? value) async {
    radioValue = value!;
    _sharedPref.save('address', address[value]);
    refresh();

  }

  void goToNewAddres () async {
   var isCreate = await Navigator.pushNamed(context, 'client/address/create');
    if(isCreate != null) {
      if( isCreate == true ) {
        refresh();
      }
    }
  }

  void createOrder ()  async {
    Address a = Address.fromJson( await _sharedPref.read('address') ?? {});
    List <Product>? selectProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    Order order = new Order(
      idClient: user!.id,
      idAddress: a.id,
      status: 'PAGADO',
      products: selectProducts,
    );
    ResponseApi? responseApi = await  _ordersProvider.create(order);
    Navigator.pushNamed(context, 'client/payments');
    print('Respuesta de la creacion de la orden: ${responseApi!.message}');
  }


}