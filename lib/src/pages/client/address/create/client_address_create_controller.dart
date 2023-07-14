import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent_finder/src/pages/client/address/map/client_address_map_page.dart';

class ClientAddressCreateController {

  late BuildContext context;
  late Function refresh;

  TextEditingController redPointController = new TextEditingController();
  Map <String, dynamic> refPoint = {};

  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

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