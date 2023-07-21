import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_finder/src/pages/client/orders/map/client_orders_map_controller.dart';

class ClientOrdersMapPage extends StatefulWidget {
  const ClientOrdersMapPage({super.key});

  @override
  State<ClientOrdersMapPage> createState() => _ClientOrdersMapPageState();
}


class _ClientOrdersMapPageState extends State<ClientOrdersMapPage> {

  ClientOrdersMapController _con = new  ClientOrdersMapController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height *0.67,
              child: _googleMaps()),
          SafeArea(
            child: Column(
              children: [
                _buttonCenterPosition (),
                Spacer(),
                _cardOrderInfo (),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _cardOrderInfo(){
    return Container(
      height: MediaQuery.of(context).size.height *0.33,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
           color: Colors.grey.withOpacity(0.5),
           spreadRadius: 5,
           blurRadius: 7,
           offset: Offset(0,3)
          )
        ]
      ),
      child: Column(
        children: [
          _listTileAddress(_con.order.address?.neighborhood,'Barrio', Icons.my_location),
          _listTileAddress(_con.order.address?.address,'Direccion', Icons.location_on_outlined),
          Divider(color: Colors.grey[400], endIndent: 30, indent: 30,),
          _deliveryInfo(),
        ],
      ),
    );
  }

 Widget _listTileAddress (String? title, String subtitle, IconData iconData){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
            title ?? '',
          style: TextStyle(
            fontSize: 13
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(iconData),
      ),
    );
 }

  Widget _buttonCenterPosition (){
    return GestureDetector(
      onTap: (){},
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.location_searching, color: Colors.grey[600], size: 20,),
          ),
        ),
      ),
    );
  }

  Widget _deliveryInfo() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 8),
      child: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              child: _con.order.delivery?.image != null
                  ?  FadeInImage(
                  image: NetworkImage(_con.order.delivery!.image!),
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                image: AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),)
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              '${_con.order.delivery?.name ??''} ${_con.order.delivery?.lastname ??''}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:  Colors.black,
                fontSize: 17,
              ),
              maxLines: 1,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[200],
            ),
            child: IconButton(
              onPressed:_con.call,
              icon: Icon(Icons.phone, color: Colors.black,),
            ),
          )
        ],
      ),
    );
  }

  Widget _googleMaps () {
    return GoogleMap(
    mapType: MapType.normal,
    initialCameraPosition: _con.initialPosition,
    onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
      polylines: _con.polyLines,

    );
  }

  void refresh () {
    setState(() {});
  }
}



