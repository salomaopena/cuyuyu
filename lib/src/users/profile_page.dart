import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/users/profile_body.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil", style: AppTheme.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: ProfileBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
