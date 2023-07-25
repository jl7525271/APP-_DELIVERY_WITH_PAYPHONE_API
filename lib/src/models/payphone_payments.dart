class PayphonePayments {
  // VARIABLES NECESARIAS

  late int amount;
  late int tax;
  late int amountWithTax;
  late String clientTransactionId;
  late String phoneNumber;
  late String email;
  late List<PayphonePayments> payPhoneWidget;

  // CONSTRUCTOR

  PayphonePayments({
    amount = 2,
    tax = 2,
    amountWithTax = 4,
    clientTransactionId = '',
    phoneNumber = '',
    email = '',
  }):
        amount = amount,
        tax= tax,
        amountWithTax = amountWithTax,
        clientTransactionId =clientTransactionId,
        phoneNumber = phoneNumber,
        email = email;



  PayphonePayments.fromJsonList( List<dynamic> jsonList  ){
        if ( jsonList == null ) {return;}
        jsonList.forEach((item) {
        final chat = PayphonePayments.fromJsonMap(item);
        payPhoneWidget.add(chat);
          });
    }

  PayphonePayments.fromJsonMap( Map<String, dynamic> json ) {
        amount = json['amount'] is String ? int.parse(json['amount']) : json['amount'];
        tax = json['tax'] is String ? int.parse(json['tax']) : json['tax'];
        amountWithTax = json['amountWithTax'] is String ? int.parse(json['amountWithTax']) : json['amountWithTax'];
        clientTransactionId = json['clientTransactionId'];
        phoneNumber = json['phoneNumber'];
        email = json['email'];
    }

    Map<String, dynamic> toJson() =>
    {
        'amout'         : amount,
        'tax'           : tax,
        'amountWithTax' : amountWithTax,
        'clientTransactionId': clientTransactionId,
        'phoneNumber'   : phoneNumber,
        'email'         : email,
    };
}