import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/users_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
class ClientUpdateController{

  BuildContext?  context;
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


  UsersProvider usersProvider = new UsersProvider();

  final  ImagePicker pickedFileImage = new ImagePicker();
  late File? imageFile = null;
  late final XFile? pickedFile;
  late Function refresh;

  late ProgressDialog _progressDialog;
  bool isEnable = true;
  User? user = User();
  SharedPref _sharedPref = new SharedPref();


  Future <void> init(BuildContext context, Function refresh ) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context!);

    user = User.fromJson( await _sharedPref.read('user'));
    usersProvider.init(context, sesionUser: user);

    nameController.text = user!.name;
    lastnameController.text = user!.lastname;
    phoneController.text = user!.phone!;

    refresh();
  }

  void update() async{
    String name= nameController.text;
    String lastName= lastnameController.text;
    String phone = phoneController.text.trim();


    print('ho: ${imageFile}');

    if (name.isEmpty || lastName.isEmpty || phone.isEmpty ){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if(imageFile == null) {
      MySnackbar.show(context, 'Selecciona una  nueva imagen');
      return;
    }

    //MUESTRA UNA BARRA DE PROGRESO O CARGA  Y DESPUES  DESACTIVA EL BOTON DE REGISTRO CON EL FALSE
    _progressDialog.show(max: 100, msg: 'Espere un momento');
    isEnable = false;

    User myUser = new User(
      id: user!.id,
      name: name,
      lastname: lastName,
      phone: phone,
      image: user!.image,
    );

    print('Ruta image2: ${imageFile}');
    if (imageFile != null) {

      Stream? stream = await usersProvider.update(myUser, imageFile!);
      stream?.listen((res) async {
        _progressDialog.close();
        //ResponseApi? responseApi = await usersProvider.create(user);
        ResponseApi? responseApi = ResponseApi.fromJson(json.decode(res));
        print('Respuestammm: ${responseApi.toJson()}');
        Fluttertoast.showToast(msg: responseApi.message);

        if (responseApi.success) {
          user = await usersProvider.getById(myUser.id);// Obteniendo el usuario
          print(('Usuario obtenido: ${user!.toJson()}'));
          _sharedPref.save('user', user!.toJson());

          Navigator.pushNamedAndRemoveUntil(
              context!, 'client/products/list', (route) => false);
        } else {
          isEnable = true;
        }
      });
      print(name);
      print(lastName);
      print(phone);
    }

  }


  Future <void> selectImage(ImageSource imageSource) async {
    pickedFile = await pickedFileImage.pickImage(source:imageSource);
    if (pickedFile !=  null ) {
      imageFile =  File(pickedFile!.path);
      print('Ruta image3: ${imageFile}');
    }
    Navigator.pop(context!);
    refresh();
  }


  void showAlertDialog(){
    Widget galleryButton = ElevatedButton(
        onPressed:(){
          selectImage(ImageSource.gallery);
        },
        child: Text('Galeria')
    );

    Widget cameraButton = ElevatedButton(
        onPressed:(){
          selectImage(ImageSource.camera);
        },
        child: Text('Camara')
    );

    AlertDialog  alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );

    showDialog(context: context!, builder: (BuildContext context ){
      return alertDialog;
    },);

  }

  void back () {
    Navigator.pop(context!);
  }

}