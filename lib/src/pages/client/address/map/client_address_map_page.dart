import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_finder/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:rent_finder/src/pages/client/address/map/client_address_map_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/widgets/no_data_widget.dart';

class ClientAddressMapPage extends StatefulWidget {
  const ClientAddressMapPage({super.key});

  @override
  State<ClientAddressMapPage> createState() => _ClientAddressMapPageState();
}


class _ClientAddressMapPageState extends State<ClientAddressMapPage> {

  ClientAddressMapController _con = new  ClientAddressMapController();
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
          title: Text(
            'Ubica tu direccion en el mapa',
          ),
        ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: _cardAddress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonSelect(),
          )
        ],
      ),
    );
  }

  Widget _buttonSelect() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed:_con.selectRefPoint,
        child: Text(
          'Seleccionar esta direccion',
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          ),
          primary: MyColors.primaryColor,
        ),
      ),
    );
  }

  Widget _cardAddress () {
    return Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            _con.addressName ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation (){
    return Image.asset(
      'assets/img/my_location.png',
      width: 65,
      height: 65,
    );
  }

  Widget _googleMaps () {
    return GoogleMap(
    mapType: MapType.hybrid,
    initialCameraPosition: _con.initialPosition,
    onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position){
      _con.initialPosition = position;
      },
      onCameraIdle: () async {
      await _con.setLocationDraggableInfo();
      },

    );
  }

  void refresh () {
    setState(() {});
  }
}



