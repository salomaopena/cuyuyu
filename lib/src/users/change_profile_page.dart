import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/colors.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
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
    super.initState();
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: kToolbarHeight),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          CircleAvatar(
                                            maxRadius: 48,
                                            backgroundColor: cuyuyuOrange100,
                                            backgroundImage: NetworkImage(
                                                snapshot.data.data()['photoUrl']),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                top: 4.0,
                                                bottom: 4.0,
                                                right: 8.0),
                                            child: TextFormField(
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14),
                                                cursorColor:
                                                    colorScheme.onSurface,
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  labelText: 'Nome',
                                                  hintText: 'Nome',
                                                ),
                                            initialValue: snapshot.data.data()['userName'],
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14),
                                              cursorColor:
                                                  colorScheme.onSurface,
                                              autofocus: true,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                labelText: 'Telefone',
                                                hintText: 'Telefone',
                                              ),
                                              initialValue: snapshot.data.data()['phoneNumber'],
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                phone = value;
                                              },
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14),
                                              cursorColor:
                                                  colorScheme.onSurface,
                                              autofocus: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                labelText: 'BI Nº',
                                                hintText: 'BI Nº',
                                              ),
                                              initialValue: snapshot.data.data()['cardId'],
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                cardId = value;
                                              },
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14),
                                              cursorColor:
                                                  colorScheme.onSurface,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                labelText: 'E-mail',
                                                hintText: 'E-mal',
                                              ),
                                              initialValue: snapshot.data.data()['userMail'],
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                email = value;
                                              },
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14),
                                              cursorColor:
                                                  colorScheme.onSurface,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                labelText: 'Género',
                                                hintText: 'Género',
                                              ),
                                              initialValue: snapshot.data.data()['gender'],
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                gender=value;
                                              },
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14),
                                              cursorColor:
                                                  colorScheme.onSurface,
                                              autofocus: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                labelText: 'Endereço',
                                                hintText: 'Endereço',
                                              ),
                                              initialValue: snapshot.data.data()['address'],
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Preenchimento obrigatório!';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                address = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 4.0,
                                                  bottom: 4.0,
                                                  right: 8.0),
                                              child: _bottonLogin(),),
                                          SizedBox(height: 10),
                                        ],
                                      ),
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
              )
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
          'Guardar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontFamily: 'Raleway',
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
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
              }).then((value){
                Toast.show('Perfil actualizado com sucesso!', context,gravity: Toast.CENTER,
                    duration: Toast.LENGTH_LONG);
              });

          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Future<DocumentSnapshot> readUserProfile() {
    return userReference.doc(auth.currentUser.uid).get();
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
                  'Meu perfil',
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
