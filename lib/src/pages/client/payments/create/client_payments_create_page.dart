import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rent_finder/src/provider/payments_provider.dart';
import 'package:rent_finder/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';


 class ClientPaymentsCreatePage extends StatefulWidget {

   ClientPaymentsCreatePage({Key? key,}) : super(key: key);

   @override
   State<ClientPaymentsCreatePage> createState() => _ClientPaymentsCreatePageState();
 }

 class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {

   ClientPaymentsCreateController _con = ClientPaymentsCreateController();
   double _progress = 0;
   InAppWebViewController? _controller;

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
     return  Container(
       child: _con.loading == true
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

       ) : Container(
           child :  Scaffold(

             appBar: AppBar (
               backgroundColor: Colors.white,
               //title: Text('Flutter Simple Example', style: TextStyle(
                 //color: Colors.black
              // ),),
             ),
             body: InAppWebView(
               initialUrlRequest: URLRequest(url: Uri.parse('https://pay.payphonetodoesposible.com/Anonymous?paymentId=upczDn8TckWvIXOMfeKyg&direct=True&redirect=%2FDirect%2FResult')),

               onWebViewCreated: (InAppWebViewController controller) {
                 // Obtiene el controlador del WebView
                 _controller = controller;
               },
               onProgressChanged: (InAppWebViewController controller , int progress){
                 setState(() {
                   _progress = progress/100;
                 });
               }
             ),
             // _progress < 1 ? Container(
             //   child: LinearProgressIndicator(
             //     value: _progress,
             //   ),
             // ): SizedBox();
        ),
     )
     );

     }
                           // WebViewWidget (controller: _con.controller),//)

                     //

   void  refresh (){
     setState(() {});}
 }


