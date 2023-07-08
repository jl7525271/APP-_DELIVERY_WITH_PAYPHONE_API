import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/pages/client/update/client_update_controller.dart';
import '../../../utils/my_colors.dart';


class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {

  ClientUpdateController _con = new ClientUpdateController();

  @override
  void initState(){
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
        title: Text('Editar perfil'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              _imageUser(),
              SizedBox(height: 30,),
              _textFielName(),
              _textFielLastName(),
              _textFielPhone(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:_buttonLogin(),
    );
  }

//widegts para la pagina de registro

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child:   _con.imageFile != null
          ? CircleAvatar(
        backgroundImage: FileImage(_con.imageFile!),
        radius: 60,
        backgroundColor: Colors.grey[200],
      )
          : _con.user?.image != null
          ? CircleAvatar(
        backgroundImage: NetworkImage(_con.user!.image!),
        radius: 60,
        backgroundColor: Colors.grey[200],
      )
          : CircleAvatar(
        backgroundImage: AssetImage("assets/img/no-image.png"),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }


  Widget _textFielName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: "Nombre",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _textFielLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastnameController,
        decoration: InputDecoration(
          hintText: "Apellido",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
              Icons.person_2_outlined, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _textFielPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        decoration: InputDecoration(
          hintText: "Telefono",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.phone, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed:_con.isEnable ? _con.update : null,
        child: Text("Actualizar perfil"),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh () {
    setState(() {
    });
  }}
