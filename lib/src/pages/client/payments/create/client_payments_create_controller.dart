
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/payphone_payments.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:rent_finder/src/provider/payments_provider.dart';
import 'package:rent_finder/src/utils/my_snackbar.dart';
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class ClientPaymentsCreateController{

  late BuildContext context;
  late Function refresh;
  String cardNumber = '';
  String expireDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool cvvFocused = false;
  PayphonePayments payphonePayments = new PayphonePayments();
   WebViewController controller = new WebViewController();
  PaymentsProvider _paymentsProvider = new PaymentsProvider();
  SharedPref _sharedPref = new SharedPref();
  User user  = new User();
  Order order = new Order();
  double total = 0;
  String link = '';
  bool loading = true;
  Uri? uri;
  String? redirectedLink = '';


  GlobalKey <FormState> keyForm = new GlobalKey();


  Future<void> init (BuildContext context, Function refresh )  async {
    this.context= context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    _paymentsProvider.init(context, user);
    getTotal ();
    generateLinkPayPhone ();
    openLink();
    refresh();

  }

  void onCreditCardModelChange (CreditCardModel creditCardModel){
    cardNumber = creditCardModel.cardNumber;
    expireDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    cvvFocused = creditCardModel.isCvvFocused;
    refresh();
  }

  void generateLinkPayPhone () async  {
   String email =  payphonePayments.email = user.email;
   int amount =  payphonePayments.amount =  (total * 100).round().toInt();
   int tax = payphonePayments.tax = 0;
   int amountWithTax =  payphonePayments.amountWithTax = (total * 100).round().toInt();
   String clientTransactionId =  payphonePayments.clientTransactionId = '${user.name}${user.name}001';
    payphonePayments.phoneNumber = user.phone;

  link =   await _paymentsProvider.generateLinkPayPhone(
        amount, tax, amountWithTax, clientTransactionId
    );
   //https://pay.payphonetodoesposible.com/Direct/Result?id=18701342&paymentId=p6fHEmMU0CIyMWc9zRMIA
   print('Link de payphone: ${link}');

   // Uri uri = Uri.parse(link);
   // uri = uri.replace(scheme: 'intent');
   // print ('URI: ${uri}');


   // controller = WebViewController()
   //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
   //   ..setBackgroundColor(const Color(0x00000000))
   //   ..setNavigationDelegate(NavigationDelegate(
   //     onPageStarted: (String url) {},
   //     onPageFinished: (String url) {},
   //     onWebResourceError: (WebResourceError error) {},
   //     onNavigationRequest: (NavigationRequest request) {
   //       if (request.url.startsWith('https://www.youtube.com/')) {
   //         return NavigationDecision.prevent;
   //       }
   //       if (request.url ==
   //           "https://pay.payphonetodoesposible.com/PayPhone/Cancelled") {
   //         cancelWebView();
   //         print('cancelado');
   //       } else if (request.url
   //           .startsWith("https://pay.payphonetodoesposible.com/Direct/")) {
   //         successWebView();
   //         print('pagado');
   //       } else if (request.url.split('/')[4] == "Expired") {
   //         expiredWebView();
   //         print('Expirado');
   //       }
   //       return NavigationDecision.navigate;
   //     },
   //   ))
   //   ..loadRequest(uri);

   print('Link de payphone: $link}');
     loading = false;
      refresh();
  }

  Future<void>  openLink() async {

    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'No se puede abrir el enlace: $link';
    }
  }


  void cancelWebView (){
    MySnackbar.show(context, "Cancelado");
  }
  void successWebView (){
    MySnackbar.show(context, "Pagado");
  }
  void expiredWebView (){
    MySnackbar.show(context, "expirado");
  }

  void getTotal (){
    total = 0;
    order.products.forEach((producto) {
      total = total + (producto.price * producto.quantity!);
    });
    refresh();
  }

}