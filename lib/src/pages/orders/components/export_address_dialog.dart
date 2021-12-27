//@dart=2.9
import 'dart:typed_data';

import 'package:cuyuyu/src/models/address/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog({this.address});

  final AddressModel address;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Endereço de entrega',
          style: GoogleFonts.roboto(
              color: Colors.deepOrange, fontWeight: FontWeight.w700)),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${address.street}, ${address.district}.\n\n'
              '${address.city}-${address.province}\n',
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      actions: [
        TextButton(
          onPressed: () async {
            await screenshotController
                .capture(delay: const Duration(milliseconds: 10))
                .then((Uint8List capturedImage) async {
              await ImageGallerySaver.saveImage(
                  Uint8List.fromList(capturedImage),
                  quality: 60,
                  name: DateTime.now().toString());
            }).catchError((onError) {
              print(onError);
            });
            Get.back(canPop: true);
          },
          child: Text(
            'Exportar',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600, color: Colors.deepOrange),
          ),
        )
      ],
    );
  }
}
