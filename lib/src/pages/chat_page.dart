import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final chatDB = FirebaseFirestore.instance;
  CollectionReference chatReference;
  final FirebaseMessaging messaging = FirebaseMessaging();

  Timestamp time = Timestamp.now();
  String text;
  String token;
  bool isTyping = false;

  @override
  void initState() {
    // TODO: implement initState
    chatReference = chatDB
        .collection(CHAT)
        .doc(auth.currentUser.uid)
        .collection(CHAT_MESSAGES);

    //get Device Token
    messaging.configure();
    messaging.getToken().then((deviceToken) {
      token = deviceToken;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                  child: auth.currentUser != null
                      ? FutureBuilder(
                          future: loadMyMessage(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Container(
                                  child: Center(
                                      child: new Text(
                                          'Internet fraca. \nPor favar, verifique a sua conexão.')),
                                );
                              case ConnectionState.waiting:
                                return Container(
                                  child: Center(
                                      child: new CircularProgressIndicator()),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Container(
                                    child: Center(
                                      child:
                                          new Text('Erro : ${snapshot.error}'),
                                    ),
                                  );
                                } else if (!snapshot.hasData) {
                                  return Center(
                                    child: Text('Sem Mensagens'),
                                  );
                                } else {
                                  return snapshot.data.docs.length > 0
                                      ? ListView.builder(
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, index) {
                                            bool isMe = snapshot.data
                                                    .docs[index]['user_id'] ==
                                                auth.currentUser.uid;
                                            return _chatCuyuyu(
                                                snapshot.data.docs[index],
                                                isMe);
                                          },
                                        )
                                      : Center(
                                          child: LinearProgressIndicator(),
                                        );
                                }
                            }
                          },
                        )
                      : Center(
                          child: Text('Utilizador inválido!'),
                        )),
              Divider(),
              Container(
                child: senderMessage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot> loadMyMessage() async {
    return FirebaseFirestore.instance
        .collection(CHAT)
        .doc(auth.currentUser.uid)
        .collection(CHAT_MESSAGES)
        .get();
  }

  Widget senderMessage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Informe sua situação',
                ),
                initialValue: text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe sua situação, por favor.';
                  }
                  return null;
                },
                onSaved: (value) {
                  text = value;
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: AppTheme.nearlyBlue,
              onPressed: () {
                auth.currentUser != null
                    ? sendMessage()
                    : Toast.show("Utilizador inválido! Inicie sessão", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Null> sendMessage() async {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      chatReference = chatDB
          .collection(CHAT)
          .doc(auth.currentUser.uid)
          .collection(CHAT_MESSAGES);

      chatReference.doc(DateTime.now().toString()).set({
        'user_id': auth.currentUser.uid,
        'user_mail': auth.currentUser.email,
        'time': time,
        'message': text,
        'device_token': token
      }).then((value) {
        _formKey.currentState.reset();
        isTyping = false;
      }).catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erro"),
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
  }

  _chatCuyuyu(QueryDocumentSnapshot doc, bool isMe) {
    Timestamp time = doc['time'];
    if (isMe) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: 8.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              padding: EdgeInsets.only(
                  left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: AppTheme.transparentYellow,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.5,
                        blurRadius: 2)
                  ]),
              child: Text(
                doc['message'],
                style: AppTheme.caption
                    .copyWith(color: AppTheme.darkerText, fontSize: 14.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                timeAgoSinceDate(time.toDate().toString()),
                style: AppTheme.caption,
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: AppTheme.notWhite.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 2)
                ]),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              padding: EdgeInsets.only(
                  left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: AppTheme.spacer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.5,
                        blurRadius: 2)
                  ]),
              child: Text(
                doc['message'],
                style: AppTheme.caption
                    .copyWith(color: AppTheme.darkerText, fontSize: 14),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: AppTheme.notWhite.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 2)
                ]),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/app_logo.png'),
                ),
              ),
              SizedBox(width: 10),
              Text(
                timeAgoSinceDate(time.toDate().toString()),
                style: AppTheme.caption,
              )
            ],
          ),
        ],
      );
    }
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
                  'Apoio & Ajuda',
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

  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} mês atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} uma semana';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semana atrás' : 'última semana';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 dia atrás' : 'ontem';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hora atrás' : 'Uma hora atrás';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minuto atrás' : 'Um minuto atrás';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} segundos atrás';
    } else {
      return 'Agora';
    }
  }
}
