//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/custom_button.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const USER_NAME = "userName";
const USER_CARD = "cardId";
const PHONE_NUMBER = "phoneNumber";
const USER_MAIL = "userMail";
const GENDER = "gender";
const ADDRESS = "address";
const PHOTO_URL = "photoUrl";

class ChangeProfilePage extends StatefulWidget {
  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final user = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userReference;

  String name;
  String phone;
  String email;
  String cardId;
  String gender;
  String address;

  @override
  void initState() {
    // TODO: implement initState

    userReference = user.collection(USER_URL);
    if (auth.currentUser != null) {
      readUserProfile();
    }
    FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Perfil", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Alterar os dados do perfil",
                      style: AppTheme.display6.copyWith(fontSize: 20),
                      textAlign: TextAlign.center),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  Container(
                    child: FutureBuilder<DocumentSnapshot>(
                      future: readUserProfile(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Container(
                              child: Center(
                                child: Text(
                                  'Internet fraca. \nPor favar, verifique a sua conexão.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Container(
                                child: Center(
                                  child: Text('Erro : ${snapshot.error}'),
                                ),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Text('Sem dados'),
                              );
                            } else {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(
                                      height: getProportionateScreenHeight(120),
                                      width: getProportionateScreenWidth(120),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        fit: StackFit.expand,
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 48,
                                            backgroundImage: NetworkImage(
                                                snapshot.data
                                                    .data()['photoUrl']),
                                          ),
                                          Positioned(
                                            right: 100,
                                            bottom: 0,
                                            child: SizedBox(
                                              height: 46,
                                              width: 46,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                color: kPrimaryColor,
                                                onPressed: () {},
                                                child: Icon(
                                                    Icons.camera_alt_outlined,
                                                color: AppTheme.nearlyWhite,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Nome',
                                        hintText: 'Nome',
                                      ),
                                      initialValue:
                                          snapshot.data.data()['userName'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
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
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      autofocus: true,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Telefone',
                                        hintText: 'Telefone',
                                      ),
                                      initialValue:
                                          snapshot.data.data()['phoneNumber'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        phone = value;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'BI Nº',
                                        hintText: 'BI Nº',
                                      ),
                                      initialValue:
                                          snapshot.data.data()['cardId'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        cardId = value;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          labelText: 'E-mail',
                                          hintText: 'E-mal',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always),
                                      initialValue:
                                          snapshot.data.data()['userMail'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        email = value;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Género',
                                        hintText: 'Género',
                                      ),
                                      initialValue:
                                          snapshot.data.data()['gender'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        gender = value;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    TextFormField(
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        labelText: 'Endereço',
                                        hintText: 'Endereço',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      initialValue:
                                          snapshot.data.data()['address'],
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Preenchimento obrigatório!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        address = value;
                                      },
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20)),
                                    _bottonLogin(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  Widget _bottonLogin() {
    return  OpenFlutterButton(
        title: 'Guardar',
        width: double.infinity,
        onPressed: () {
          bool isValid = _formKey.currentState.validate();
          if (isValid) {
            _formKey.currentState.save();
            userReference.doc(auth.currentUser.uid).update({
              USER_NAME: name,
              PHONE_NUMBER: phone,
              USER_MAIL: email,
              ADDRESS: address,
              USER_CARD: cardId,
              GENDER: gender,
            }).then((value) {
              Toast.show('Perfil actualizado com sucesso!', context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            });
          }
        },
    );
  }

  Future<DocumentSnapshot> readUserProfile() {
    return userReference.doc(auth.currentUser.uid).get();
  }
}
