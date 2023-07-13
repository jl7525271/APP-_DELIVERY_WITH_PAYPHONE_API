import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/pages/client/products/details/client_products_detail_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';

class ClientProductsDetailPage extends StatefulWidget {

   Product product = new Product();
   ClientProductsDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ClientProductsDetailPage> createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {

  ClientProductsDetailController _con = new ClientProductsDetailController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.86,
      child: Column(
        children: [
          _imageSlideShow(),
          _textName(),
          _textDescription(),
          Spacer(),
          _addOrRemoveItem (),
          _standarDelivery(),
          _buttonShoppingBag (),
        ],
      ),
    );
  }

  Widget _textName () {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30, top: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        _con.product?.name ?? '',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textDescription () {
    return Container(
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        _con.product?.description ?? '',
        style: TextStyle(
          fontSize: 13,
          color:  Colors.grey,
        ),
      ),
    );
  }

  Widget _addOrRemoveItem () {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        children: [
          IconButton(
              onPressed: _con.addItem,
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 30 ,
              ),
          ),
          Text(
            '${_con.counter ?? 0}',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: _con.removeItem,
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30 ,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              '\$ ${_con.productPrice ?? 0}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _standarDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/img/delivery.png',
            height: 17,
          ),
          SizedBox(width: 10),
          Text(
            'Envio estandar',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonShoppingBag () {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40,  top: 40, bottom: 35),
      child: ElevatedButton(
        onPressed: _con.addToBag,
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 2), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Agregar al carrito',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 50,top: 10),
                height: 30,
                child: Image.asset('assets/img/bag.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSlideShow () {
    return Stack(
      children: [
        Container(
          //margin: EdgeInsets.only(top: 25),
          child: ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height *0.4,
            initialPage: 0,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            children: [
              (_con.product?.image1 != null
                  ?  FadeInImage(
                  image: NetworkImage(_con.product!.image1),
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 500),
                  placeholder: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                  image: AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.contain  ,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'))),

              (_con.product?.image2 != null
                  ?  FadeInImage(
                  image: NetworkImage(_con.product!.image2),
                  fit: BoxFit.contain ,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                  image: AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'))),

              (_con.product?.image3 != null
                  ?  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: FadeInImage(
                    image: NetworkImage(_con.product!.image3),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png')),
                  )
                  : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FadeInImage(
                    image: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png')
                ),
                  )
              ),
            ],
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 30000,
            /// Loops back to first slide.
            isLoop: true,
          ),
        ),
        Positioned(
          left: 5,
          top: 11,
            child: IconButton(
              onPressed: _con.close,
              icon: Icon(Icons.arrow_back_ios),
              color: MyColors.primaryColor,
            )
        )
      ],
    );
  }

  void refresh () {
    setState(() {});
  }

}
