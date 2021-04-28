import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  String email;
  bool isLoading = false;

  Future<void> resetPassword(String email,) async {
    _firebaseAuth.sendPasswordResetEmail(email: email).then((result) {
      isLoading = false;
      Toast.show(
        "Consulte o email " + email + " para redefinir a senha.",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Informação",
                style: AppTheme.textTheme.headline5,
              ),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              getAppBarUI(),
              Expanded(
                child: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: Center(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20.0, top: 20.0),
                                    child: Text(
                                      'Informe os dados',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextFormField(
                                    initialValue: email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            fontFamily: 'Raleway',
                                            fontSize: 14),
                                    cursorColor: colorScheme.onSurface,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      labelText: 'Email',
                                      hintText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
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
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: RaisedButton(
                                      color: AppTheme.cuyuyuLigthBlue,
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Enviar',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                                fontFamily: 'Raleway',
                                                color: cuyuyuSurfaceWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                      ),
                                      onPressed: () {
                                        bool isValid =
                                            _formKey.currentState.validate();
                                        if (isValid) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          _formKey.currentState.save();
                                          resetPassword(email);
                                          _formKey.currentState.reset();
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              offset: const Offset(0, 0),
              blurRadius: 0.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 10,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Alterar senha',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
