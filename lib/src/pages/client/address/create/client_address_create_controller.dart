import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/pages/client/address/map/client_address_map_page.dart';
import 'package:rent_finder/src/provider/address_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';

class ClientAddressCreateController {

  late BuildContext context;
  late Function refresh;

  TextEditingController redPointController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController neighborhoodController = new TextEditingController();
  Map <String, dynamic> refPoint = {};

  User user = new User();
  SharedPref _sharedPreferences = new SharedPref();

  AddressProvider _addressProvider = new AddressProvider();

  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPreferences.read('user'));

    _addressProvider.init(context, user);

  }

  void createAddress ()  async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    double lat = refPoint['lat'] ?? 0;
    double lng = refPoint['lng'] ?? 0;

    if(addressName.isEmpty || neighborhood.isEmpty || lat == 0 || lng == 0 ) {
      MySnackbar.show(context, 'Completa todos los campos');
      return;
    }

    Address address = new Address(
        idUser: user.id,
        address: addressName,
        neighborhood: neighborhood,
        lat: lat,
        lng: lng
    );

    ResponseApi?  responseApi =  await _addressProvider.create(address);

    if(responseApi!.success) {
      Fluttertoast.showToast(msg: responseApi.message);
      Navigator.pop(context);
    }
  }


  void openMap()  async {
    refPoint= await showMaterialModalBottomSheet( //PARA MOSTRAR LA DESCRIPCION DE UN PRODUCTO
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => ClientAddressMapPage()
    );

    if (refPoint != null) {
      redPointController.text = refPoint['address'];
      refresh();
    }
  }





}