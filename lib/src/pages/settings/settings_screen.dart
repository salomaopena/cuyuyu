//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/notification/notifications_page.dart';
import 'package:cuyuyu/src/pages/profile/profile_screen.dart';
import 'package:cuyuyu/src/pages/settings/faq_screen.dart';
import 'package:cuyuyu/src/pages/settings/help_screen.dart';
import 'package:cuyuyu/src/pages/settings/privacy_policy_screen.dart';
import 'package:cuyuyu/src/pages/settings/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Definições',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
          child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            const Text(
              'Geral',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            ListTile(
              title: const Text(
                'Termos de uso',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.list,
                color: Colors.black,
              ),
              onTap: () => Get.to(() => TermsConditionsScreen()),
            ),
            ListTile(
                title: const Text(
                  'Privacidade',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: const Icon(
                  Icons.security,
                  color: Colors.black,
                ),
                onTap: () => Get.to(() => PrivacyPage())),
            ListTile(
              title: const Text(
                'Notificações',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onTap: () {
                Get.to(() => NotificationPage());
              },
            ),
            ListTile(
              title: const Text(
                'FAQ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.question_answer,
                color: Colors.black,
              ),
              onTap: () => Get.to(() => FaqScreen()),
            ),
            ListTile(
              title: const Text(
                'Ajuda',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.help,
                color: Colors.black,
              ),
              onTap: () => Get.to(() => HelpScreen()),
            ),
            const SizedBox(height: 16),
            const Text(
              'Conta',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Consumer<UserManager>(builder: (_, UserManager userManager, __) {
              if (!userManager.isLoggedIn) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Inicie sessão para ver todas as definições',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return ListTile(
                title: const Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                onTap: () => Get.to(() => ProfileScreen()),
              );
            }),
          ],
        ),
      )),
    );
  }
}
