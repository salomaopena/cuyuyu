//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:cuyuyu/src/models/cart/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddressInpuField extends StatelessWidget {
  const AddressInpuField({this.address});
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;
    if ((address.latitude != 1.1 && address.longitude != 1.1) &&
        cartManager.deliveryPrice <= 0.0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: address.street,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'Rua/Avenida',
              hintText: 'Av. Deolinda Rodrigues',
            ),
            validator: emptyValidator,
            onSaved: (street) => address.street = street,
            style: const TextStyle(fontSize: 16, color: AppColors.nearlyBlack),
          ),
          TextFormField(
            initialValue: address.district,
            decoration: const InputDecoration(
                labelText: 'Bairro', hintText: 'Dr. António Agostinho Neto'),
            validator: emptyValidator,
            onSaved: (district) => address.district = district,
            style: const TextStyle(fontSize: 16, color: AppColors.nearlyBlack),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: address.city,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Cidade',
                    hintText: 'Lubango',
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  validator: emptyValidator,
                  onSaved: (city) => address.city = city,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  initialValue: address.province,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Província',
                    hintText: 'Huíla',
                  ),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  onSaved: (province) => address.province = province,
                  textCapitalization: TextCapitalization.characters,
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Campo obrigatório*';
                    } else if (text.length < 3) {
                      return 'Inválido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          TextFormField(
            initialValue: address.country,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'País',
              hintText: 'Angola',
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black),
            validator: emptyValidator,
            onSaved: (country) => address.country = country,
          ),
          const SizedBox(height: 8),
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
            onPressed: () async {
              if (Form.of(context).validate()) {
                Form.of(context).save();
                try {
                  await context.read<CartManager>().setAddress(address);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$error'),
                    backgroundColor: AppColors.redColor,
                  ));
                }
              }
            },
            child: !cartManager.loading
                ? const Text("Calcular frete")
                : const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          )
        ],
      );
    } else if (address.latitude != 1.1 && address.longitude != 1.1) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          '${address.street}, ${address.district},'
          ' ${address.city}-${address.province}',
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 12,
          fontWeight: FontWeight.w400),
        ),
      );
    } else {
      return Container();
    }
  }
}
