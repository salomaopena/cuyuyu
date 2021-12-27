//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "O seu dispositivo não tem suporte para esta funcionalidade..."),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone(String phone) async {
      final String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
      if (await canLaunch('tel:$cleanPhone')) {
        launch('tel:$cleanPhone');
      } else {
        showError();
      }
    }

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Sobre',
          style: TextStyle(
            color: AppColors.closeColor,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Image.asset(
                'images/app_logo.png',
                height: 150,
                width: 150,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'CUYUYU ENTREGAS, é uma plataforma que permite que você receba os melhores '
                'produtos da sua cidade em minutos. Diga o que deseja e um entregador Cuyuyu '
                'levará aonde quer que você esteja.',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13,
                  wordSpacing: 2,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Contactos',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SelectableText(
                '+244 926 542 671',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(),
                onTap: () => openPhone('926542671'),
              ),
              const SizedBox(height: 4),
              SelectableText(
                '+244 926 682 532',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(),
                onTap: () => openPhone('926682532'),
              ),
              const SizedBox(height: 4),
              SelectableText(
                'cuyuyu.entregras@outlook.com',
                style: GoogleFonts.roboto(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                toolbarOptions: const ToolbarOptions(
                    copy: true, selectAll: true, cut: false, paste: false),
              ),
              Divider(),
              const Text(
                'Desenvolvido por',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/fenix.png',
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.error,
                    size: 40,
                    color: Colors.red,
                  ),
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Oferecemos soluções adequadas para o seu negócio. '
                'Somos parceiros de eleição em nossa esfeira de actuação. '
                'O nosso objectivo é a satisfação de nossos clientes.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13,
                  wordSpacing: 2,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Contactos',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '+244 940 171 369',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '+244 928 079 933',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
