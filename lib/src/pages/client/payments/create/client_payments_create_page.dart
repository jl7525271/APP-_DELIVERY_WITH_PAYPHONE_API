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
          backgroundColor: Colors.white,
          title: Text('Your Title Here'), // Agrega un título personalizado aquí
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _con.openLink,
                child: Text('PAYPHONE'),
              ),
              SizedBox(height: 20),
              if (redirectedUrl != null)
                Text('URL redirigida: $redirectedUrl')
              else
                Text('Esperando redirección...'),
              Expanded(
                child: InAppWebView(
                  //initialUrlRequest: URLRequest(url: Uri.parse('about:blank')),
                  onLoadStart: (controller,url) {
                    setState(() {
                      redirectedUrl = url.toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WebViewWidget (controller: _con.controller),//)

  //

  void  refresh (){
    setState(() {});}
}