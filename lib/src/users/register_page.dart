import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/custom_drawer/navigation_home_screen.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/image_placeholder.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const USER_NAME = "userName";
const USER_CARD = "cardId";
const PHONE_NUMBER = "phoneNumber";
const USER_MAIL = "userMail";
const GENDER = "gender";
const ADDRESS = "address";
const PHOTO_URL = "photoUrl";
const IS_ONLINE = "isOnline";
const USER_TYPE = "userType";
const TIMESTAMP = "created";

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key, this.app});

  @override
  _RegisterPageState createState() => _RegisterPageState();
  final FirebaseApp app;
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscuredText = true;
  bool _confirmPassword = true;

  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;
  String address;

  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  final userReference = FirebaseFirestore.instance.collection(USER_URL);

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  void registerToFb() {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) {
      userReference.doc(result.user.uid).set({
        USER_NAME: name,
        PHONE_NUMBER: phone,
        USER_MAIL: email,
        ADDRESS: address,
        USER_CARD: 'default',
        GENDER: 'default',
        PHOTO_URL: 'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331257_960_720.png',
        USER_TYPE:'Cliente',
        TIMESTAMP: Timestamp.now()
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
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
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: name,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Preenchimento obrigatório!';
                                  }
                                  if (value.trim().length < 3) {
                                    return 'O Nome não pode ser tão curto! No mínimo 3 letras.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  name = value;
                                },
                                textCapitalization: TextCapitalization.words,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Nome',
                                  hintText: 'Nome',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: phone,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Preenchimento obrigatório!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  phone = value;
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Telefone',
                                  hintText: 'Telefone',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: email,
                                onSaved: (value) {
                                  email = value;
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'E-mail',
                                  hintText: 'E-mal',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: password,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Preenchimento obrigatório!';
                                  }
                                  if (value.trim().length < 8) {
                                    return 'A Palavra-passe não deve ser menor que 8';
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
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                obscureText: _confirmPassword,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _confirmPassword = !_confirmPassword;
                                      });
                                    },
                                    child: Icon(_confirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: confirmPassword,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Preenchimento obrigatório!';
                                  }
                                  if (value.trim().length < 8) {
                                    return 'A Palavra-passe não deve ser menor que 8';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  confirmPassword = value;
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                obscureText: _obscuredText,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Confirmar password',
                                  hintText: 'Confirmar password',
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
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                initialValue: address,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Preenchimento obrigatório!';
                                  }
                                  if (value.trim().length < 5) {
                                    return 'O Endereço não pode ser tão curto! No mínimo 5 letras.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  address = value;
                                },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Endereço',
                                  hintText: 'Endereço',
                                ),
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    top: 4.0,
                                    bottom: 4.0,
                                    right: 8.0),
                                child: _bottonLogin()),
                            SizedBox(height: 25),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          NavigationHomeScreen()));
                                },
                                child: Text(
                                  'Já tenho conta',
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: AppTheme.nearlyBlue,
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
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

  Widget _bottonLogin() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: RaisedButton(
        color: AppTheme.cuyuyuOrange,
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Cadastrar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontFamily: 'Raleway',
              color: AppTheme.cuyuyuSurfaceWhite,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          bool isValid = _formKey.currentState.validate();
          if (isValid) {
            if (password == confirmPassword) {
              _formKey.currentState.save();
              //register();
              registerToFb();
              _showExitDialog(context);
            } else {
              return 'Palavra-passe não confere';
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok",
          style: AppTheme.textTheme.bodyText1.copyWith(
              color: AppTheme.cuyuyuOrange, fontWeight: FontWeight.bold)),
      onPressed: () {
        _formKey.currentState.reset();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NavigationHomeScreen(),
        ));
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Informação",
        style: AppTheme.textTheme.headline6
            .copyWith(color: AppTheme.darkerText, fontWeight: FontWeight.bold),
      ),
      content: Text("Dados cadastrado com sucesso!"),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
                  'Criar conta',
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
}
