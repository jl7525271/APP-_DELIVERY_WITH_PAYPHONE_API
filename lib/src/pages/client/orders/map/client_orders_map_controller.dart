import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_map_polyline_point/flutter_polyline_point.dart';
import 'package:flutter_google_map_polyline_point/point_lat_lng.dart';
import 'package:flutter_google_map_polyline_point/utils/polyline_result.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location ;
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/orders_provider.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ClientOrdersMapController {

  late BuildContext context;
  late Function refresh;
  String? addressName = '';
  LatLng? addressLatLng;
  double? _distanceBetween;

  //SOCKET IO
  late IO.Socket socket;
  
  late Position? _position;
  CameraPosition initialPosition = CameraPosition(
      target: LatLng(-2.923478, -79.066152),
      zoom: 20, // puede ir de 1 - 20
  );

  late BitmapDescriptor? deliveryMarker;
  late BitmapDescriptor? homeMarker;

  Map<MarkerId, Marker> markers = <MarkerId, Marker> {};
  Completer <GoogleMapController> _mapController  = Completer();
  Order order = new Order();
  Uri? url;
  Set<Polyline> polyLines = {};
  List<LatLng> points = [];
  OrdersProvider _ordersProvider = new OrdersProvider();
  User user = new User();
  SharedPref _sharedPref = new SharedPref();

  Future <void> init (BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    order = Order.fromJson(ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>);
    print('Orden como argumento: ${order!.toJson()}');
    deliveryMarker = await createMarkerFromAssets('assets/img/delivery2.png');
    homeMarker = await createMarkerFromAssets('assets/img/home.png');

    //CONECTANDO AL SOCKET IO DEL SERVIDOR
    socket = IO.io('http://${Environment.API_DEILVERY}/orders/delivery', <String, dynamic> {
      'transports':['websocket'],
      'autoConnect':false,
    });
    socket.connect();
    //EL SOCKET ON SIRVE PARA LEER UN EVENTO QUE SE ENVIA DESDE EL SERVIDOR
    socket.on('position/${order.id}', (data) {
      print('Recibido de servidor: ${data.toString()}');
      addMarker(
          'delivery',
          data['lat'],
          data['lng'],
          'Tu delivery',
          '',
          deliveryMarker!
      );
    });

    user = User.fromJson( await _sharedPref.read('user'));
    _ordersProvider.init(context, user);
   // url = Uri.parse("https://api.whatsapp.com/send?phone=593${order.client!.phone}");
    checkGPS();
    refresh();
  }

  void isCloseToDeliveryPosition() {
    _distanceBetween = Geolocator.distanceBetween(
        _position!.latitude,
        _position!.longitude,
        order.address!.lat,
        order.address!.lng
    );
  }

  Future <void>  setPolylines (LatLng from, LatLng to )  async {
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);

    PolylineResult result =await PolylinePoints().getRouteBetweenCoordinates(
        Environment.API_KEYS_MAPS,
        pointFrom,
        pointTo);

    for (PointLatLng point in result.points) {
      points.add(LatLng(point.latitude, point.longitude));
    }
    Polyline polyline = Polyline(
        polylineId: PolylineId('poly'),
        color: MyColors.primaryColor,
        points: points,
        width: 6
    );
    polyLines.add(polyline);

    refresh();
  }

 void call(){
   launchUrlString("tel://${order.delivery!.phone}");
  }

  void selectRefPoint () {
    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addressLatLng!.latitude,
      'lng': addressLatLng!.longitude,
    };
    Navigator.pop(context, data);
  }

  Future<Null> setLocationDraggableInfo()  async {
    if(initialPosition != null ) {
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark> address = await placemarkFromCoordinates(lat, lng);
      if(address != null) {
        if( address.length >0 ){
          String? direction = address[0].thoroughfare;
          String? street = address[0].subThoroughfare;
          String? city = address[0].locality;
          String? department = address[0].administrativeArea;

          addressName = '${direction} ${street} ${city}, ${department}';
          addressLatLng = new LatLng(lat, lng);
            print('Lat: ${addressLatLng!.latitude}');
            print('Lat: ${addressLatLng!.longitude}');
          refresh();
        }
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    //controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]');
    _mapController.complete(controller);
  }

  void dispose() {
    socket?.disconnect();
  }

  void updateLocation() async {
    try{
      await _determinePosition(); // Obtiene la posicion actual y solicita permisos
      //_position = (await Geolocator.getLastKnownPosition())!; //lat y long

      // addMarker(
      //     'Delivery',
      //     _position!.latitude,
      //     _position!.longitude,
      //     'Tu posicion',
      //     '',
      //     deliveryMarker!
      // );

      animatedCameraToPosition(order.lat!, order.lng!);
      addMarker(
          'delivery',
          order.lat!,
          order.lng!,
          'Tu delivery',
          '',
          deliveryMarker!
      );

      addMarker(
          'Home',
          order!.address!.lat,
          order!.address!.lng,
          'Lugar de entrega',
          '',
          homeMarker!
      );

      LatLng from = new LatLng(order.lat!, order.lng!);
      LatLng to = new LatLng(order.address!.lat, order.address!.lng);
      setPolylines(from, to);
      refresh();
    }catch(e){
      print('Error: $e');
    }
    refresh();
  }

  void checkGPS () async {
    bool isLocationEneable = await Geolocator.isLocationServiceEnabled();
    if(isLocationEneable) {
      updateLocation();
    }else {
      bool locationGPS = await location.Location().requestService();
      if(locationGPS) {
        updateLocation();
      }
    }
  }

  Future <void> animatedCameraToPosition (double lat, double lng) async {
    GoogleMapController controller = await _mapController.future;

    if( controller != null ) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14,
          bearing: 0
      )));
    }
  }

  /// Determine the current position of the device.When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  
  Future <BitmapDescriptor> createMarkerFromAssets ( String path) async  {
    ImageConfiguration configuration =  ImageConfiguration();
    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker (String markerId, double lat, double lng, String title, String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat,lng),
        infoWindow: InfoWindow(title: title, snippet: content)
    );
    markers[id] = marker;

    refresh();
  }
}