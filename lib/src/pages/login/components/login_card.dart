//@dart=2.9
import 'package:cuyuyu/src/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Faça login para ter acesso',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  enableFeedback: true,
                  onSurface: Colors.grey,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                  Get.to(()=>LoginScreen());
                },
                child: Text("Iniciar sessão",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
