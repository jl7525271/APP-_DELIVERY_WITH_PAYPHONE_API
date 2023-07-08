import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:rent_finder/src/pages/login/login_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   loginController _con = new loginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //_imageBanner (),
                  _lottieAnimation(),
                  _textBanner (),
                  _textFielEmail(),
                  _textFielPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount(),
                ],
              ),
            ),

            Positioned(
                top: -80,
                left: -100,
                child: _circleLogin()
            ),
            Positioned(
              child: _textLogin(),
              top: 70,
              left: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLogin (){
    return Text(
        "LOGIN",
      style: TextStyle(
        fontFamily: "NimbusSans",
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    );
  }

  Widget _textBanner (){
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.width*0.20,
      ),
      child: Text(
        "RENT FINDER",
            style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
      ),
    );
  }
  Widget _textDontHaveAccount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No tienes cuenta?",
          style: TextStyle(
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(width: 7,),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            "Registrate",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonLogin () {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text("Ingresar"),
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

  Widget _textFielEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo electronico",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.email, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _textFielPassword (){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.lock, color: MyColors.primaryColor),
        ),
      ),
    );
  }

  Widget _circleLogin (){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _lottieAnimation (){
    return Container(
      margin: EdgeInsets.only(
        top: 120,
        bottom: MediaQuery.of(context).size.width*0.01,
      ),
      child: Lottie.asset(
          "assets/json/home.json",
        width: 350,
        height: 200,
        fit: BoxFit.fill,

      ),
    );
  }
  Widget _imageBanner (){
    return Container(
      margin: EdgeInsets.only(
          top: 100,
          bottom: MediaQuery.of(context).size.width*0.01,
      ),
      child: Image.asset(
          'assets/img/casa.png',
          width: 200,
          height: 200,
      ),
    );
  }
}
