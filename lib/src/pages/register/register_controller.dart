import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/users_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
class registerController{

  BuildContext?  context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  final  ImagePicker _pickedFile = new ImagePicker();
    File? imageFile;
  late Function refresh;
  late ProgressDialog _progressDialog;
  bool isEnable = true;


  Future? init(BuildContext context, Function refresh ){
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context!);
    usersProvider.init(context);
  }
  void register () async{
    String email= emailController.text.trim();
    String name= nameController.text;
    String lastName= lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmpasswordController.text.trim();

    if (email.isEmpty || lastName.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
    if(confirmPassword!= password){
      MySnackbar.show(context, "Las contraseñas no coinciden");
      return;
    }
    if(password.length < 6){
      MySnackbar.show(context, "Las contrasenas debe tener al menos 6 caracteres");
      return;
    }

    if(imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }
    //MUESTRA UNA BARRA DE PROGRESO O CARGA  Y DESPUES  DESACTIVA EL BOTON DE REGISTRO CON EL FALSE
    _progressDialog.show(max: 100, msg: 'Espere un momento');
    isEnable = false;

    User user = new User(
      email: email,
      name: name,
      lastname: lastName,
      phone: phone,
      password: password,
    );


    // Declara la suscripción como una variable opcional
    //StreamSubscription? subscription;
    // Cancela la suscripción anterior, si existe
   // subscription?.cancel();
    Stream? stream = await usersProvider.createWithImage(user, imageFile!);
   // subscription =
        stream?.listen((res) {
      _progressDialog.close();
      //ResponseApi? responseApi = await usersProvider.create(user);
      ResponseApi? responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), (){
          Navigator.pushReplacementNamed(context!, 'login');
        });
      } else {
        isEnable = true;
      }
    });

    print(email);
    print(name);
    print(lastName);
    print(phone);
    print(password);
    print(confirmPassword);
  }

  Future <void> selectImage(ImageSource imageSource) async {
    final XFile? pickedFile = await _pickedFile.pickImage(source:imageSource!);
    if (pickedFile !=  null ) {
      imageFile =  File(pickedFile.path.toString());
      print('Ruta image2: ${imageFile}');
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