//@dart=2.9
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/default_button.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  String email;
  bool isLoading =  false;

  Future<void> resetPassword(
    String email,
  ) async {
    _firebaseAuth.sendPasswordResetEmail(email: email).then((result) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Sucesso",
                style: AppTheme.title,
              ),
              content: Text(
                "Consulte o email " + email + " para redefinir a senha",
                style: AppTheme.display4,
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Ok",
                    style: AppTheme.display4,
                  ),
                  onPressed: () {
                    isLoading = false;
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ), (route) => false);
                  },
                )
              ],
            );
          });
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Informação",
                style: AppTheme.title,
              ),
              content: Text(
                "Ocorreu um erro. Verifique o seu email",
                style: AppTheme.display4,
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Ok",
                    style: AppTheme.display4,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar senha", style: AppTheme.title),
        iconTheme: IconThemeData.fallback(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16.0),
                right: getProportionateScreenWidth(16.0)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Informe os dados',
                    textAlign: TextAlign.start,
                    style: AppTheme.title.copyWith(fontFamily: 'Muli'),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25.0),
                  ),
                  TextFormField(
                    initialValue: email,
                    style: AppTheme.display4,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Preenchimento obrigatório!';
                      }
                      if (!value.trim().contains('@') ||
                          !value.trim().contains('.')) {
                        return 'Informe um email válido!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 20),
                  DefaultButton(
                    text: !isLoading?"Enviar":"Aguarde...",
                    press: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                          _formKey.currentState.save();
                          resetPassword(email);
                          _formKey.currentState.reset();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
