import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rent_finder/src/pages/client/payments/create/client_payments_create_controller.dart';



class ClientPaymentsCreatePage extends StatefulWidget {

  ClientPaymentsCreatePage({Key? key,}) : super(key: key);

  @override
  State<ClientPaymentsCreatePage> createState() => _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {

  ClientPaymentsCreateController _con = ClientPaymentsCreateController();

  String? redirectedUrl;




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
    return Container(
      child: _con.loading
          ? Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              )
            ],
          ),
        ),
      )
          : Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Container(
            margin: EdgeInsets.only(left:70 ),
            child: Text('Payphone',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
               // fontStyle: FontStyle.italic,
                letterSpacing: 1.3,
                shadows: [ // Sombras del texto
                  Shadow(offset: Offset(1, 2), color: Colors.grey, blurRadius: 2),
                ],
              )
            ),
          ), // Agrega un título personalizado aquí
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/payphone.png'), // Ruta de la imagen
                fit: BoxFit.cover, // Ajuste de la imagen dentro del Container
              ),
            ),
          height: MediaQuery.of(context).size.height * 0.09,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10,),
              buttonLinkPay (),
            ],
          )
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _pagePayphone(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonLinkPay (){
    return Container(
      child: ElevatedButton(
        onPressed: _con.openLink,
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
            elevation: 5,
        ),
        child: Text('Generar link de pago',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }

  Widget _pagePayphone() {
    // Asegúrate de especificar una altura para el InAppWebView
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90, // Especifica aquí la altura deseada
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://www.payphone.app/')),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useOnLoadResource: true,
            useShouldOverrideUrlLoading: true,
          ),
        ),
        onLoadError: (controller, url, code, message) {
          print("Error al cargar la página: $url, code: $code, message: $message");
        },
      ),
    );
  }


  void  refresh (){
    setState(() {});}
}