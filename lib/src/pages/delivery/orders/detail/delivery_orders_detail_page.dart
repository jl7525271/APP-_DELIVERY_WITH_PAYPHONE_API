import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/models/product.dart';
import 'package:rent_finder/src/pages/delivery/orders/detail/delivery_orders_detail_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/utils/relative_time_util.dart';
import 'package:rent_finder/src/widgets/no_data_widget.dart';

class DeliveryOrdersDetailPage extends StatefulWidget {

  Order order = new Order();
  DeliveryOrdersDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  State<DeliveryOrdersDetailPage> createState() => _DeliveryOrdersDetailPageState();
}

class _DeliveryOrdersDetailPageState extends State<DeliveryOrdersDetailPage> {

  DeliveryOrdersDetailController _con = new DeliveryOrdersDetailController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
      _con.init(context, refresh, widget.order); // con widget se llama a la order que ya fue instanciado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden \# ${_con.order?.id ?? ''}'),
        backgroundColor: MyColors.primaryColor,
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.37,
        child:SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                color: Colors.grey[400],
                endIndent: 30, // Para establecer margen en la parte derecha
                indent: 30, // para la parte izquierda
              ),
              SizedBox(height: 10,),
              _textDataClient('Cliente: ','${_con.order.client!.name ?? ''} ${_con.order.client!.lastname ?? ''}' ),
              _textData ('Entregar en: ','${_con.order.address!.address ?? ''}'),
              _textDataClient (
                  'Fecha de pedido: ','${RelativeTimeUtil.getRelativeTime(_con.order.timestamp ?? 0)}' ),
              SizedBox(height: 20,),
              _textTotalPrice(),
              _buttonNext ()
            ],
          ),
        ),
      ),
      body: _con.order!.products.length > 0
          ?  ListView(
              children:_con.order!.products.map((Product product) {
                return _carProduct(product);
              }).toList())
          : Container(
          alignment: Alignment.center,
            child: NoDataWidget(text:'Ningun producto agregado')),
    );
  }

  Widget _carProduct (Product product ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          imageProduct (product),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  product.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Cantidad: ${product?.quantity ?? 0 }',
                style: TextStyle(
                fontSize: 13,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              _textPrice(product)
            ]
          )
        ],
      ),
    );
  }

  Widget _textPrice (Product product) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '\$ ${product.price! * product.quantity!}',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget imageProduct (Product product) {
    return Container(
        width: 75,
        height: 75,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200],
        ),
        child: product.image1 != null
            ?  FadeInImage(
            image: NetworkImage(product.image1),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'))
            : FadeInImage(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/img/no-image.png'),)
    );
  }

  Widget _textData (String title, String content ){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
      child:ListTile(
        title: Text(
            title,
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            content,
            style: TextStyle(fontSize: 16,),
            maxLines: 2,),
        ),
      )
    );
  }
  Widget _textDataClient(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width:8,),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
            ),
            maxLines: 2,
          ),

        ],
      ),
    );
  }

  Widget _textTotalPrice () {
    return Container(
      margin: EdgeInsets.only(right: 30, left:30,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),

          Text(
            '\$ ${_con.total}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonNext () {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40,  top: 10, bottom: 35),
      child: ElevatedButton(
        onPressed: _con.updateOrder,
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
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
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'Iniciar entrega',
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
                margin: EdgeInsets.only(left: 50,top: 9),
                height: 24,
                child: Icon(Icons.directions_bike_outlined, color: Colors.white,size: 24,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void refresh () {
    setState(() {
    });
  }
}
