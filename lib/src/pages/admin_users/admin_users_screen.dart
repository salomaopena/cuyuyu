//@dart=2.9
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/orders/admin_orders_manager.dart';
import 'package:cuyuyu/src/models/page/page_manager.dart';
import 'package:cuyuyu/src/models/users/admin_users_manager.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  AdminUsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Utilizadores',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, AdminUsersManager adminUserManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, int index) {
              return ListTile(
                title: Text(
                  adminUserManager.users[index].userName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(adminUserManager.users[index].userMail,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                    )),
                onTap: () {
                  context.read<AdminOrdersManager>().setUserFilter(
                        adminUserManager.users[index]
                    );
                    context.read<PageManager>().setPage(7);
                },
                onLongPress: ()async{
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            'Excluir conta',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          content: Text(
                            'Tem certeza que deseja excluir a conta?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await adminUserManager.deleteUserAccount(
                                    userModel: adminUserManager.users[index],
                                    onError: (onError){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Ocorreu um erro ao excluir a conta: $onError"),
                                        backgroundColor: AppColors.redColor,
                                      ));
                                    }
                                );
                                Get.back();
                              },
                              child: const Text(
                                'Sim',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Get.back(canPop: true);
                              },
                              child: const Text(
                                'Não',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        );
                      });
                },
                isThreeLine: true,
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(adminUserManager.users[index].userName
                        .substring(0, 1))),
                enableFeedback: true,
              );
            },
            keyboardUsage: true,
            strList: adminUserManager.names,
            indexedHeight: (int index) => 60,
            showPreview: true,
            highlightTextStyle: GoogleFonts.roboto(
              color: Colors.deepOrange,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          );
        },
      ),
    );
  }
}
