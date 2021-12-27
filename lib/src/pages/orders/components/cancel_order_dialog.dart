//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/orders/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelOrderDialog extends StatefulWidget {
  const CancelOrderDialog({this.order});

  final Order order;

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  bool loading = false;
  String error;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('Cancelar ${widget.order.formattedId}?',
          style: GoogleFonts.roboto(
            color: AppColors.closeColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loading
                ? 'Cancelando...'
                : 'Esta acção não poderá ser desfeita'),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: !loading
                ? () {
                    Get.back();
                  }
                : null,
            child: Text('Voltar'),
          ),
          TextButton(
              onPressed: !loading
                  ? () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await widget.order.cancel();
                        Get.back();
                      } catch (error) {
                        setState(() {
                          loading = false;
                          this.error = error.toString();
                        });
                      }
                    }
                  : null,
              child: Text(
                'Cancelar pedido',
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
