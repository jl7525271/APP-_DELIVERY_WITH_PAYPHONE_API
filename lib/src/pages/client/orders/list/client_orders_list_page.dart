import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/pages/client/orders/list/client_orders_list_cotroller.dart';
import 'package:rent_finder/src/pages/client/products/list/client_products_list_page_controller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/utils/relative_time_util.dart';
import 'package:rent_finder/src/widgets/no_data_widget.dart';

class ClientOrdersListPage extends StatefulWidget {
  const ClientOrdersListPage({super.key});

  @override
  State<ClientOrdersListPage> createState() => _ClientOrdersListPageState();
}

class _ClientOrdersListPageState extends State<ClientOrdersListPage> {

  ClientOrdersListController _con = ClientOrdersListController();

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
    return DefaultTabController(
      length: _con.status.length,
      child: Scaffold(
          key: _con.key,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),

            child: AppBar(
              foregroundColor: Colors.black,
              title: Text('Mis pedidos', style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,

              bottom: TabBar(
                  indicatorColor: MyColors.primaryColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  tabs: List<Widget>.generate(_con.status.length, (index) {
                    return Tab(
                      child: Text(_con.status[index] ?? ''),
                    );
                  })
              ),
            ),
          ),

          body: TabBarView(
            children:_con.status.map((String status) {
              return FutureBuilder( // Listar informacion de la lista de datos. Si son varios datos
                future: _con.getOrders(status),
                builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data!.length > 0 ){
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          itemCount: snapshot.data!.length ?? 0,
                          itemBuilder: (_,index) {
                            return _cardOrder(snapshot.data![index]);
                          }
                      );
                    }else{return NoDataWidget(text: 'No hay ordenes');}
                  }else{return NoDataWidget(text: 'No hay ordenes');}
                },
              );
            }).toList(),
          )
      ),
    );
  }

  Widget _cardOrder (Order order) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(order);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 140,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width *1,
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Orden \# ${order.id}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'NimbusSans'
                        ),
                      ),
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(

                        'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp ?? 0)} ',
                        style: TextStyle(
                            fontSize: 13
                        ),maxLines: 2,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Repartidor: ${order.delivery?.name ?? 'No asignado'} ${order.delivery?.lastname ?? ''}' ,
                        style: TextStyle(
                            fontSize: 13
                        ),maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Entregar en: ${order.address?.address ?? ''}',
                        style: TextStyle(
                            fontSize: 13
                        ),
                        maxLines: 2,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refresh (){
    setState(() {});
  }
}
