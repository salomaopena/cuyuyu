//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/users/change_password.dart';
import 'package:cuyuyu/src/users/register_page.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/config.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/default_button.dart';
import 'package:cuyuyu/src/utils/image_placeholder.dart';
import 'package:cuyuyu/src/utils/no_account.dart';
import 'package:cuyuyu/src/utils/progress_dialog.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:cuyuyu/src/utils/socal_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _obscuredText = true;
  String email = "";
  String password = "";
  ProgressDialog pr;

  final _formKey = new GlobalKey<FormState>();

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final userReference = FirebaseFirestore.instance.collection(USER_URL);


  @override
  initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: AppTheme.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(16.0),
              right: getProportionateScreenWidth(16.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FadeInImagePlaceholder(
                image: const AssetImage('images/logo_app.png'),
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenWidth(150),
                placeholder: Container(
                  width: getProportionateScreenWidth(32),
                  height: getProportionateScreenHeight(32),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                        initialValue: email,
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
                        style: AppTheme.display4
                            .copyWith(fontFamily: 'Muli'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'E-mail',
                          hintText: 'E-mal',
                        ),
                      ),

                    SizedBox(height: 10),

                    TextFormField(
                        initialValue: password,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
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
                        style: AppTheme.display4
                            .copyWith(fontFamily: 'Muli'),
                        obscureText: _obscuredText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
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

                    SizedBox(height: getProportionateScreenHeight(25)),

                    DefaultButton(
                      text: "Iniciar sessão",
                      press: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          siginIn(email, password);
                          KeyboardUtil.hideKeyboard(context);
                        }
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Center(
                      child: Text(
                        'OU',
                        style: AppTheme.display4,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SocalCard(
                            icon: "images/facebook.png",
                            press: () {
                              Toast.show(
                                "Indisponível! Tente outra forma.",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER,
                              );
                            },
                          ),
                        ),
                        Flexible(
                            child: SocalCard(
                          icon: "images/google.png",
                          press: () {
                            googleSignIn();
                          },
                        )),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(16.0),
                          right: getProportionateScreenWidth(16.0)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.to(()=>ChangePasswordPage());
                                });
                              },
                              child:Text('Esqueci a palavra-passe',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.caption.copyWith(
                                          color: AppTheme.cuyutyuBlue,
                                          fontWeight: FontWeight.bold))
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    NoAccountText(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result =
      await _firebaseAuth.signInWithCredential(authCredential);

      User user = _firebaseAuth.currentUser;

      if (result.additionalUserInfo.isNewUser) {
        userReference.doc(user.uid).set({
          ID: user.uid,
          USER_NAME: user.displayName,
          PHONE_NUMBER: user.phoneNumber,
          USER_MAIL: user.email,
          ADDRESS: 'default',
          USER_CARD: 'default',
          GENDER: 'default',
          PHOTO_URL:
          'https://images.unsplash.com/photo-1542309667-2a115d1f54c6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTN8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          USER_TYPE: 'Cliente',
          TIMESTAMP: Timestamp.now()
        }).then((res) {
          pr.style(
              message: 'Aguarde...',
              borderRadius: 10.0,
              backgroundColor: Colors.white,
              progressWidget: CircularProgressIndicator(),
              elevation: 10.0,
              insetAnimCurve: Curves.easeInOut,
              progress: 0.0,
              maxProgress: 100.0,
              progressTextStyle: AppTheme.caption,
              messageTextStyle: AppTheme.display6);
          pr.show();
          Future.delayed(Duration(seconds: 5)).then((value) {
            pr.hide().whenComplete(() {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ), (route) => false);
            });
          });
        });
      } else {
        pr.style(
            message: 'Aguarde...',
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            progress: 0.0,
            maxProgress: 100.0,
            progressTextStyle: AppTheme.caption,
            messageTextStyle: AppTheme.display6);
        pr.show();
        Future.delayed(Duration(seconds: 5)).then((value) {
          pr.hide().whenComplete(() {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ), (route) => false);
          });
        });
      }

      print(user.uid);
      return Future.value(true);
    }
  }

  Future<bool> siginIn(
       String email, String password) async {
    try {
       await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _formKey.currentState.reset();
      pr.style(
          message: 'Aguarde...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: AppTheme.caption,
          messageTextStyle: AppTheme.display6);
      pr.show();
      Future.delayed(Duration(seconds: 5)).then((value) {
        pr.hide().whenComplete(() {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ), (route) => false);
        });
      });

    } catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.title,
                  ),
                  content: Text('Endereço de email parece mal formado',style: AppTheme.display4,),
                  actions: [
                    FlatButton(
                      child: Text("Ok",style: AppTheme.display4,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('our email address appears to be malformed.');
          break;
        case 'wrong-password':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.title,
                  ),
                  content: Text('Password errada',style: AppTheme.display4,),
                  actions: [
                    FlatButton(
                      child: Text("Ok", style: AppTheme.display4,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('our email address appears to be malformed.');
          break;
        case 'user-not-found':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.title,
                  ),
                  content: Text('Não existe nenhum utilizador com este email', style: AppTheme.display4,),
                  actions: [
                    FlatButton(
                      child: Text("Ok",style: AppTheme.display4,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('User with this email doesn\'t exist');
          break;
        case 'user-disabled':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.title,
                  ),
                  content: Text('Endereço de email desabilitado',style: AppTheme.display4,),
                  actions: [
                    FlatButton(
                      child: Text("Ok",style: AppTheme.display4,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('User with this email has been disabled.');
          break;
        default:
          print('Erro inesperado!');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.textTheme.headline5,
                  ),
                  content: Text('Erro inesperado. Tente outra vez'),
                  actions: [
                    TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          break;
      }
    }
  }

}



