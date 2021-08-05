//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/constants.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:cuyuyu/src/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Timestamp time = Timestamp.now();
  String text;
  bool isTyping = false;

  @override
  void initState() {
    // TODO: implement initState
    chatReference = chatDB
        .collection(CHAT)
        .doc(auth.currentUser.uid)
        .collection(CHAT_MESSAGES);

    //get Device Token

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          appBar: AppBar(
            title: const Text("Chat", style: AppTheme.title),
            elevation: 0,
            iconTheme: IconThemeData.fallback(),
            backgroundColor: Colors.transparent,
            foregroundColor: AppTheme.nearlyBlack,
          ),
          body: Column(
            children: <Widget>[
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
              SizedBox(height: getProportionateScreenHeight(10),)
            ],
          ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
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
                  TextButton(
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
