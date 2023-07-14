import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/widgets/no_data_widget.dart';


class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({super.key});

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {

  ClientAddressListController _con = new  ClientAddressListController();
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
          'Direcciones',
        ),
        actions: [
          _iconAdd(),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
            children: [
              _textSelectAddress(),
              Container(
                margin: EdgeInsets.only(top: 10),
                  child: NoDataWidget(text: 'Agrega una nueva direccion')
              ),
              _iconAddAddress (),
              //_buttonNewAddress (),
            ],
        ),
      ),
      bottomNavigationBar: _buttonAccept (),
    );
  }

  Widget _iconAddAddress (){
    return Stack(
      children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[600]
            ),
          ),
       IconButton(
            onPressed: _con.goToNewAddres,
            icon: Icon(Icons.add, color: Colors.white,)
        ),
      ],
    );

  }

  Widget _iconAdd (){
    return IconButton(
        onPressed: _con.goToNewAddres,
        icon: Icon(Icons.add, color: Colors.black,)
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Elije donde recibir tus productos: ',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonAccept () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
            'Aceptar',
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


  Widget _buttonNewAddress () {
    return Container(
      height: 40,
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
          'Nueva direccion',
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
      ),
    );
  }

  void refresh () {
    setState(() {});
  }
}
