//@dart=2.9
import 'package:cuyuyu/src/models/checkout/checkout_manager.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({Key key}) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  Payment _payment = Payment.money;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Formas de pagamento',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<CheckoutManager>(
              builder: (_, CheckoutManager checkoutManager, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Payment.values.map((Payment payment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: RadioListTile<Payment>(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.lerp(
                                const BorderSide(width: 1),
                                BorderSide(
                                    width: 1,
                                    color: Colors.deepOrange.shade100),
                                1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        title: Text(
                          Order.getPaymentText(payment.index),
                          style: GoogleFonts.roboto(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        dense: true,
                        autofocus: true,
                        groupValue: _payment,
                        activeColor: Theme.of(context).primaryColor,
                        value: payment,
                        onChanged: (Payment value) {
                          setState(() {
                            _payment = value;
                            checkoutManager.payment =
                                Order.getPaymentText(value.index);
                          });
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
