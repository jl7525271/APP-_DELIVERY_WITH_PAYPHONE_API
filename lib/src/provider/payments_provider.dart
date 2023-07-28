import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_finder/src/api/environment.dart';
import 'package:rent_finder/src/models/address.dart';
import 'package:rent_finder/src/models/response_api.dart';
import 'package:rent_finder/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rent_finder/src/utils/shared_pref.dart';
import 'package:rent_finder/src/models/payphone_payments.dart';


class PaymentsProvider {

  String token = Environment.TOKEN;
  late BuildContext? context;
  User sessionUser = new User();


  Future <void> init (BuildContext context,User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }


  //SE GENERA UN LINK DE PAGO CON LA INFORMACIÓN UTILIZANDO LA API DE PAYPHONE Y DEVOLVEMOS LA URL RESULTANTE

Future <String> generateLinkPayPhone (amount, tax, amountWithTax, clientTransactionId) async {
    var response = await http.post(
        Uri.parse('https://pay.payphonetodoesposible.com/api/Links'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
        "amount": 112,
        "tax": 12,
        "amountWithTax": 100,
        "clientTransactionId": "idlink001",
        "currency": "USD",
          "expireIn": 1
        }));
    String link = json.decode(response.body);
    print('payphone: ${link}');


    final responseweb = await http.get(Uri.parse(link));  //Uri.parse(link)
    Map <String, String> headers = {
      'Content-type':'application/json',
      'Authorization' : sessionUser.seccion_token
    };
      if (responseweb.statusCode == 200) {
        // Si la solicitud fue exitosa, obtén el link redireccionado del encabezado "location"
        final link = responseweb.headers['location'];
        print('redirectLink: ${link}');

        if (link != null) {
          // Si se encontró el link redireccionado, devuélvelo
          return link;
        } else {
          // Si no se encontró el link redireccionado en el encabezado "location", lanza una excepción
          throw Exception('No se encontró el link redireccionado en el encabezado "location"');
        }

      } else {
        // Si la solicitud no fue exitosa, lanza una excepción
        throw Exception('Error al obtener el link redireccionado. Código de estado: ${response.statusCode}');
      }
      }
  }
