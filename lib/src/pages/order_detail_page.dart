//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final DocumentSnapshot item;

  const OrderDetailPage({Key key, this.item}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    String cancelado = widget.item['orderStatus'];

    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              getAppBarUI(),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pedido Nº',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              color: AppTheme.cuyutyuBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.item.id.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              color: AppTheme.cuyutyuBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    !cancelado.contains('Cancelado')
                        ? Text(
                            widget.item['orderStatus'],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            widget.item['orderStatus'],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                child: getDetailList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getDetailList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0, bottom: 8.0),
        itemCount: List.from(widget.item['orderDetail']).length,
        itemBuilder: (context, index) {
          List<Map<dynamic, dynamic>> values =
              List.from(widget.item['orderDetail']);
          return Card(
            elevation: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 125,
                      width: 110,
                      padding: EdgeInsets.only(
                          left: 0, top: 10, bottom: 70, right: 20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: values[index]['image'] != null ||
                                      values[index]['image'].isNotEmpty
                                  ? NetworkImage(values[index]['image'])
                                  : AssetImage('images/app_logo.png'),
                              fit: BoxFit.cover)),
                      child: values[index]['discount'] == null
                          ? Container()
                          : Container(
                              color: Colors.deepOrange,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '${values[index]['discount']}%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "Promoção",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              values[index]['product'],
                              style: TextStyle(
                                  color: AppTheme.cuyuyuOrange,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                            SizedBox(height: 5),
                            Text(
                              values[index]['unity'] +
                                  ' | ' +
                                  values[index]['variation'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            Text(
                              '${int.parse(values[index]['quantity'])} x',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.cuyuyuLigthBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '\Kz ${double.parse(values[index]['price'])}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '\Kz ${(double.parse(values[index]['price']) * double.parse(values[index]['quantity']))}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.cuyutyuBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    values[index]['description'],
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 0),
              blurRadius: 0.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Detalhes do pedidos',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 10,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
