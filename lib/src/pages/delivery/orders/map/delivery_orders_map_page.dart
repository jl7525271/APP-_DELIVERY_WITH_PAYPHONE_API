import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_finder/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';


class DeliveryOrdersMapPage extends StatefulWidget {
  const DeliveryOrdersMapPage({super.key});

  @override
  State<DeliveryOrdersMapPage> createState() => _DeliveryOrdersMapPageState();
}


class _DeliveryOrdersMapPageState extends State<DeliveryOrdersMapPage> {

  DeliveryOrdersMapController _con = new  DeliveryOrdersMapController();
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
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height *0.60,
              child: _googleMaps()),
          SafeArea(
            child: Column(
              children: [
                _buttonCenterPosition (),
                Spacer(),
                _cardOrderInfo (),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonNext () {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30,  top: 5, bottom: 5),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Entregar producto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 55,top: 7),
                height: 24,
                child: Icon(Icons.check_circle_outline, color: Colors.white,size: 24,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardOrderInfo(){
    return Container(
      height: MediaQuery.of(context).size.height *0.40,
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
          _clientInfo (),
          _buttonNext (),
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

  Widget _clientInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(
        children: [
          Container(
              height: 50,
              width: 50,
              child: _con.order.client?.image != null
                  ?  FadeInImage(
                  image: NetworkImage(_con.order.client!.image!),
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
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '${_con.order.client?.name ??''} ${_con.order.client?.lastname ?? ''}',
              style: TextStyle(
                color:  Colors.black,
                fontSize: 17,
              ),
              maxLines: 1,
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[200],
            ),
            child: IconButton(
              onPressed: (){},
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

    );
  }

  void refresh () {
    setState(() {});
  }
}



