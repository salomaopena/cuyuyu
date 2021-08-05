//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/pages/home/home_screen.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/default_button.dart';
import 'package:cuyuyu/src/utils/have_account.dart';
import 'package:cuyuyu/src/utils/image_placeholder.dart';
import 'package:cuyuyu/src/utils/progress_dialog.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const USER_NAME = "userName";
const USER_CARD = "cardId";
const ID = "id";
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

  ProgressDialog pr;

  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  final userReference = FirebaseFirestore.instance.collection(USER_URL);

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta", style: AppTheme.title),
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
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
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
                        style: AppTheme.display4,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Nome',
                          hintText: 'Nome',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
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
                        style: AppTheme.display4,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Telefone',
                          hintText: 'Telefone',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: email,
                        onSaved: (value) {
                          email = value;
                        },
                        style: AppTheme.display4,
                        keyboardType: TextInputType.emailAddress,
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
                            return 'A Palavra-passe não deve ser menor que 8';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                        style: AppTheme.display4,
                        obscureText: _confirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
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
                      SizedBox(height: 10),
                      TextFormField(
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
                        style: AppTheme.display4,
                        obscureText: _obscuredText,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
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
                      SizedBox(height: 10),
                      TextFormField(
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
                        style: AppTheme.display4,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Endereço',
                          hintText: 'Endereço',
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 10),
                      DefaultButton(
                        text: "Cadastrar",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            if (password == confirmPassword) {
                              _formKey.currentState.save();
                              registerToFb();
                            } else {
                              return 'Palavra-passe não confere';
                            }
                          }
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      HaveAccount(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> registerToFb() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userReference.doc(value.user.uid).set({
          ID: value.user.uid,
          USER_NAME: name,
          PHONE_NUMBER: phone,
          USER_MAIL: email,
          ADDRESS: address,
          USER_CARD: 'default',
          GENDER: 'default',
          PHOTO_URL:
              'https://images.unsplash.com/photo-1542309667-2a115d1f54c6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTN8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          USER_TYPE: 'Cliente',
          TIMESTAMP: Timestamp.now()
        }).then((res) {
          setState(() {
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
        });
      });
      return Future.value(true);
    } catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          print('our email address appears to be malformed.');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Criar conta",
                    style: AppTheme.title,
                  ),
                  content: Text('Já existe utilizador com este email'),
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
          break;
        case 'invalid-email':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Criar conta",
                    style: AppTheme.title,
                  ),
                  content: Text('Endereço de email inválido'),
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
          print('our email address appears to be malformed.');
          break;
        case 'operation-not-allowed':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Criar conta",
                    style: AppTheme.title,
                  ),
                  content: Text('Operação inválida', style: AppTheme.display4),
                  actions: [
                    TextButton(
                      child: Text("Ok", style: AppTheme.display4),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('our email address appears to be malformed.');
          break;
        case 'weak-password':
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Login",
                    style: AppTheme.title,
                  ),
                  content: Text('Password não cumpre com os requisitos',
                      style: AppTheme.display4),
                  actions: [
                    TextButton(
                      child: Text("Ok", style: AppTheme.display4),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          print('our email address appears to be malformed.');
          break;
        default:
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Criar conta",
                    style: AppTheme.title,
                  ),
                  content: Text('Erro inesperado. Tente outra vez',
                      style: AppTheme.display4),
                  actions: [
                    TextButton(
                      child: Text("Ok", style: AppTheme.display4),
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
