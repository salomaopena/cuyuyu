import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/users/register_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/image_placeholder.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _obscuredText = true;
  bool isLoading = false;
  String email;
  String password;

  AnimationController animationController;

  final _formKey = GlobalKey<FormState>();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> logInToFb(
    @required String email,
    @required String password,
  ) async {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
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
  initState() {
    Firebase.initializeApp();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: SingleChildScrollView(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 140,
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                  child: _cuyuyuLogo(),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: TextFormField(
                                      initialValue: email,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontFamily: 'Raleway',
                                              fontSize: 14),
                                      cursorColor: colorScheme.onSurface,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        labelText: 'E-mail',
                                        hintText: 'E-mal',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: TextFormField(
                                      initialValue: password,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        if (value.trim().length < 8) {
                                          return 'A senha não pode ser menor que 8 Caracteres';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        password = value;
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontFamily: 'Raleway',
                                              fontSize: 14),
                                      cursorColor: colorScheme.onSurface,
                                      obscureText: _obscuredText,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        labelText: 'Password',
                                        hintText: 'Password',
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscuredText = !_obscuredText;
                                            });
                                          },
                                          child: Icon(_obscuredText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: RaisedButton(
                                        color: AppTheme.cuyuyuOrange,
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          'Iniciar sessão',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  fontFamily: 'Raleway',
                                                  color: AppTheme.cuyuyuSurfaceWhite,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () {
                                          bool isValid =
                                              _formKey.currentState.validate();
                                          if (isValid) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            _formKey.currentState.save();
                                            logInToFb(email, password);
                                            _formKey.currentState.reset();
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  NavigationHomeScreen(),
                                            ));
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterPage()));
                                            },
                                            child: Text(
                                              'Junta-te a nós',
                                              textAlign: TextAlign.start,
                                              style: AppTheme
                                                  .textTheme.subtitle2
                                                  .copyWith(
                                                      color:
                                                          AppTheme.cuyutyuBlue),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Text(
                                                'Esqueci a palavra-passe',
                                                textAlign: TextAlign.end,
                                                style: AppTheme
                                                    .textTheme.subtitle2
                                                    .copyWith(
                                                        color: AppTheme
                                                            .cuyutyuBlue)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(height: 10),
                                  Center(
                                    child: Text('OU'),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: SignInButton(
                                      Buttons.Google,
                                      text: 'Google',
                                      onPressed: () {},
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        top: 4.0,
                                        bottom: 4.0,
                                        right: 8.0),
                                    child: SignInButton(
                                      Buttons.Facebook,
                                      text: 'Facebook',
                                      onPressed: () {},
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
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
              width: AppBar().preferredSize.height + 40,
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
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
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

  Widget _cuyuyuLogo() {
    return FadeInImagePlaceholder(
      image: const AssetImage('images/logo_app.png'),
      height: 150,
      width: 150,
      placeholder: Container(
        width: 32,
        height: 32,
      ),
    );
  }
}
