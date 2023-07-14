import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';



class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({super.key});

  @override
  State<ClientAddressCreatePage> createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {

  ClientAddressCreateController _con = new  ClientAddressCreateController();
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
          'Nueva direccion',
        ),
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFielAddress(),
          _textFielNeighborhood(),
          _textFielRefPoint(),
        ],
      ),
    );
  }

  Widget _textFielAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(Icons.location_on, color: MyColors.primaryColor,),

        ),
      ),
    );
  }

  Widget _textFielNeighborhood() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Barrio',
          suffixIcon: Icon(Icons.location_city, color: MyColors.primaryColor,),

        ),
      ),
    );
  }

  Widget _textFielRefPoint() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.redPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Referencia de la ubicacion',
          suffixIcon: Icon(Icons.map, color: MyColors.primaryColor,),
        ),
      ),
    );
  }


  Widget _buttonAccept() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
          'Crear direccion',
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

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa estos datos: ',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }


  void refresh () {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}