//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {
  const CepInputField({this.address});
  final AddressModel address;

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    if (widget.address.latitude == 1.1 && widget.address.longitude == 1.1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.all(10),
              enableFeedback: true,
              onSurface: Colors.grey,
              textStyle: const TextStyle(
                fontSize: 18,
              ),
              backgroundColor: AppColors.closeColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            onPressed: !cartManager.loading
                ? () async {
                    if (Form.of(context).validate()) {
                      try {
                        await context.read<CartManager>().determinePosition();
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$error'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  }
                : null,
            child: !cartManager.loading
                ? const Text("Endereço de entrega")
                : const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${widget.address.city} - ${widget.address.province}',
                style: TextStyle(
                    color: AppColors.closeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            CustomIconButton(
                icon: Icons.edit,
                color: AppColors.closeColor,
                size: 20,
                onTap: () {
                  context.read<CartManager>().removeAddress();
                })
          ],
        ),
      );
    }
  }
}
