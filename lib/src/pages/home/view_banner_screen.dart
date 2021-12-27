//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/banners/banner.dart';
import 'package:flutter/material.dart';

class ViewBannerScreen extends StatelessWidget {
  final BannerModel banner;
  const ViewBannerScreen({this.banner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Outdoor',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              banner.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
