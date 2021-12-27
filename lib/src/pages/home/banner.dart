//@dart=2.9
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/banners/banner_manager.dart';
import 'package:cuyuyu/src/pages/home/view_banner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.23,
      child: Consumer<BannerManager>(
        builder: (_, bannerManager, __) {
          final items = bannerManager.allItems;
          if (items.isEmpty) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.closeColor),
              backgroundColor: Colors.transparent,
            );
          }
          return Carousel(
            boxFit: BoxFit.cover,
            dotSize: 4,
            radius: const Radius.circular(5),
            indicatorBgPadding: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: AppColors.closeColor,
            autoplay: true,
            animationCurve: Curves.slowMiddle,
            animationDuration: const Duration(milliseconds: 3000),
            onImageTap: (i) {
              final banner = items[i];
              if (banner != null) {
                Get.to(() => ViewBannerScreen(banner: banner));
              }
            },
            images: items.map((item) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  progressIndicatorBuilder: (_, __, downloadProgress) => Center(
                      child:  CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: const AlwaysStoppedAnimation(Colors.deepOrange),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
