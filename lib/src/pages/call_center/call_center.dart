//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "O seu dispositivo não tem suporte para esta funcionalidade..."),
        backgroundColor: Colors.red,
      ));
    }

    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text(
            'Call Center',
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shrinkWrap: true,
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.asset('images/app_logo.png'),
                ),
                const Text(
                  'Como podemos ajudar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.deepOrange),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Parece que você está tendo problemas '
                  '\ncom nossos serviços. Estamos aqui para '
                  '\najudar, portanto, entre em contato conosco',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SelectableText(
                  '+244 926 542 671',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  toolbarOptions: const ToolbarOptions(
                      copy: true, selectAll: true, cut: false, paste: false),
                  onTap: () async {
                    final String phone =
                        '926542671'.replaceAll(RegExp(r'[^\d]'), '');
                    if (await canLaunch('tel:${phone}')) {
                      launch('tel:${phone}');
                    } else {
                      showError();
                    }
                  },
                ),
                const SizedBox(height: 8),
                SelectableText(
                  '+244 926 682 532',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  toolbarOptions: const ToolbarOptions(
                      copy: true, selectAll: true, cut: false, paste: false),
                  onTap: () async {
                    final String phone =
                        '926682532'.replaceAll(RegExp(r'[^\d]'), '');
                    if (await canLaunch('tel:${phone}')) {
                      launch('tel:${phone}');
                    } else {
                      showError();
                    }
                  },
                ),
                const SizedBox(height: 8),
                const SelectableText(
                  'cuyuyu.entregras@outlook.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  toolbarOptions: ToolbarOptions(
                      copy: true, selectAll: true, cut: false, paste: false),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async => canLaunch(
                      await 'https://web.facebook.com/Cuyuyu-Entregas-100721258317817'),
                  child: const Text(
                    'Siga-nos no Facebook',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
