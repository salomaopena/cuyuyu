//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/models/stores/store.dart';
import 'package:cuyuyu/src/pages/product_store/product_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({@required this.store});

  final Stores store;

  @override
  Widget build(BuildContext context) {
    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.yellow;
        case StoreStatus.closed:
          return Colors.red;
        default:
          return Colors.green;
      }
    }

    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "O seu dispositivo não tem suporte para esta funcionalidade..."),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${store.cleanPhone}')) {
        launch('tel:${store.cleanPhone}');
      } else {
        showError();
      }
    }

    Future<void> openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                              coords: Coords(store.longitude as double,
                                  store.longitude as double),
                              title: store.name,
                              description: store.addressText);
                          Get.back();
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      )
                  ],
                ),
              );
            });
      } catch (e) {
        showError();
      }
    }

    return GestureDetector(
      onTap: () => Get.to(() => ProductStoreSreen(store: store)),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: store.image,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    progressIndicatorBuilder:
                        (_, __, DownloadProgress downloadProgress) => Center(
                            child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.deepOrange),
                    )),
                    errorWidget: (_, __, ___) => Image.asset(
                      'images/app_logo.png',
                      repeat: ImageRepeat.noRepeat,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16))),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        store.statusText,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorForStatus(store.status)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 140,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          store.name.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          store.addressText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          store.openingText,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                          icon: Icons.map,
                          color: AppColors.cuyuyuOrange,
                          onTap: openMap),
                      CustomIconButton(
                          icon: Icons.phone,
                          color: AppColors.cuyuyuOrange,
                          onTap: openPhone),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
