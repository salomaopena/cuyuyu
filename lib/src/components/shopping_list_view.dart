//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ShoppingListView extends StatefulWidget {
  final VoidCallback callback;
  final DocumentSnapshot shopping;

  const ShoppingListView({Key key, this.callback, this.shopping})
      : super(key: key);
  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.shopping['orderDate'];
    String cancelado = widget.shopping['orderStatus'];

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(4.0)),
      child: GestureDetector(
        onTap: () {
          widget.callback();
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(26.0)),
            child: Stack(
              children: [
                Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        color: AppTheme.nearlyWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '#' + widget.shopping.id.toString(),
                              style: AppTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.closeColor,
                                fontFamily: 'Muli',
                              ),
                            ),
                            SizedBox(height: 5),
                            cancelado.contains('Cancelado')
                                ? Text(
                                    widget.shopping['orderStatus'],
                                    style: AppTheme.display1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Muli',
                                    ),
                                  )
                                : Text(
                                    widget.shopping['orderStatus'],
                                    style: AppTheme.display1.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Muli'),
                                  ),
                            SizedBox(height: 5),
                            Text(
                              timeAgoSinceDate(timestamp.toDate().toString()),
                              style: AppTheme.display4,
                            ),

                            //Divider(),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Subtotal',
                                          style: AppTheme.display4,
                                        ),
                                        Text('Frete', style: AppTheme.display4),
                                        Text('Total',
                                            style: AppTheme.display1.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Muli',
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\Kz ${widget.shopping['subtotal']}',
                                          style: AppTheme.display4,
                                        ),
                                        Text(
                                          '\Kz ${widget.shopping['frete']}',
                                          style: AppTheme.display4,
                                        ),
                                        Text(
                                          '\Kz ${widget.shopping['total']}',
                                          style: AppTheme.display1.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Muli',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            !cancelado.contains('Cancelado')
                                ? Container(
                                    transform: Matrix4.identity(),
                                    child: TextButton(
                                      child: Text('Cancelar pedido',
                                      style: AppTheme.display1.copyWith(
                                        color: AppTheme.closeColor,
                                        fontWeight: FontWeight.w600
                                      )),
                                      onPressed: () {
                                        updateStatus();
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateStatus() {
    Timestamp timestamp = widget.shopping['orderDate'];
    final now = Timestamp.now();
    final difference = now.toDate().difference(timestamp.toDate());

    if (difference.inMinutes <= 15) {
      FirebaseFirestore.instance
          .collection(ORDERS)
          .doc(widget.shopping.id)
          .update({
        ORDER_DATE: Timestamp.now(),
        STATUS: "Cancelado",
      }).then((value) {
        Toast.show("Cancelado com sucesso!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }).catchError((onError) {
        Toast.show("Ocorreu um erro: " + onError.toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    } else {
      _showExitDialog(context);
    }
  }

  void _showExitDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Ok",
        style: AppTheme.textTheme.bodyText1.copyWith(
            color: AppTheme.dismissibleBackground, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Informação",
        style: AppTheme.title
            .copyWith(color: AppTheme.darkerText, fontWeight: FontWeight.bold),
      ),
      content: Text(
          "Excedeu o tempo limite.\nJá não se pode cancelar o pedido. O tempo limite é de 15 minutos."),
      actions: [
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} mês atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} uma semana';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semana atrás' : 'última semana';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 dia atrás' : 'ontem';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minuto atrás' : 'Um minuto atrás';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} segundos atrás';
    } else {
      return 'Agora';
    }
  }
}
