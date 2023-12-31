import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rent_finder/src/models/order.dart';
import 'package:rent_finder/src/pages/delivery/orders/list/delivery_orders_list_cotroller.dart';
import 'package:rent_finder/src/utils/my_colors.dart';
import 'package:rent_finder/src/utils/relative_time_util.dart';
import 'package:rent_finder/src/widgets/no_data_widget.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({super.key});

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {

  DeliveryOrdersListController _con = DeliveryOrdersListController();

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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,

              flexibleSpace: Column(
                children: [
                  SizedBox(height: 80),
                  _menuDrawer(),
                ],
              ),
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

          drawer: _drawer(),

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
                        'Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}' ,
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

  Widget _menuDrawer (){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer(){
    return Drawer (
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: MyColors.primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      '${_con.user?.email ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    '${_con.user?.phone ?? ''}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 60,
                    child: _con.user?.image != null
                        ? FadeInImage(
                        placeholder: AssetImage("assets/img/no-image.png"),
                        image: NetworkImage(_con.user.image.toString()), //NetworkImage(img),
                        fit: BoxFit.contain,
                        fadeInDuration: Duration(milliseconds: 50),)
                        : Image.asset("assets/img/no-image.png", fit: BoxFit.contain),
                  ),
                ],
              )
          ),

          //MUESTRA ESTA OPCION EN PAGINA DEL CLIENTE SOLO SI ESTE USUARIO TIENE MAS DE UN ROL
          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_2_outlined),
          ) : Container() : Container(),

          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new_outlined),
          ),
        ],
      ),
    );
  }

  void refresh (){
    setState(() {});
  }
}
