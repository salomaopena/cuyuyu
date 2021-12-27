//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/common/icon_badge.dart';
import 'package:cuyuyu/src/models/notification/notifications_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Notificações',
            style: TextStyle(
                color: AppColors.closeColor,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            Consumer<NotificationsManager>(
                builder: (_, NotificationsManager notificationsManager, __) {
              final notifications = notificationsManager.notifications;
              return IconBadge(
                icon: const Icon(Icons.notifications, color: Colors.deepOrange),
                itemCount: notifications.length,
                hideZero: true,
                onTap: () {},
              );
            })
          ]),
      body: Consumer<NotificationsManager>(
        builder: (_, NotificationsManager notificationsManager, __) {
          final notificationsList = notificationsManager.notifications;
          if (notificationsList.isEmpty) {
            return Center(
              child: Text(
                'Sem notificações',
                style: GoogleFonts.roboto(
                    color: AppColors.nearlyBlack, fontSize: 15),
              ),
            );
          }
          return ListView.separated(
            itemCount: notificationsList.length,
            itemBuilder: (_, index) => Card(
              elevation: 0,
              color: index.isEven ? Colors.white : AppColors.spacer,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                    title: Text(
                      notificationsList[index].title,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.deepOrange),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          notificationsList[index].body,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notificationsList[index].dateText,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    trailing: CustomIconButton(
                      color: Colors.red,
                      icon: Icons.remove,
                      onTap: () => notificationsManager.deleteNotifications(
                          id: notificationsList[index].id),
                    )),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(
                height:
                    1) /*Divider(
              height: 8,
              indent: 16,
              endIndent: 16,
            )*/
            ,
          );
        },
      ),
    );
  }
}
