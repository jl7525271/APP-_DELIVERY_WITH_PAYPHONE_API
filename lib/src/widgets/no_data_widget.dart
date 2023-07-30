import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  late String text = '';

  NoDataWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(16), // Ajusta el padding según tus necesidades
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/no_items.png'),
                      Text(text),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

