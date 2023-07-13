import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  late String text ='';
  NoDataWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/no_items.png'),
          Text('No hay producto')
        ],
      ),
    );
  }
}
