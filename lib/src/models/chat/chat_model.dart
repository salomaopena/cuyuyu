//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatModel {
  String id;
  Timestamp time;
  String message;
  String userId;
  String token;

  ChatModel({this.id, this.time, this.message, this.userId, this.token});

  ChatModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    time = doc.get('time') as Timestamp;
    message = doc.get('message') as String;
    userId = doc.get('user_id') as String;
    token = doc.get('device_token') as String;
  }
  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc("Chat/$userId");

  CollectionReference get chatReference => firestoreRef.collection("messages");

  Future<void> send(UserModel user) async {
    token = await FirebaseMessaging.instance.getToken();
    userId = user.userId;
    String time = Timestamp.now().toDate().toString();
    chatReference.doc(time).set({
      'message': message,
      'time': Timestamp.now(),
      'user_id': userId,
      'device_token': token,
    });
  }

  String get dateText => getTimeAgoSinceDate(time.toDate().toString());

  static String getTimeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} anos atrás';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 ano atrás' : 'ano anterior';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} meses atrás';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 mês atrás' : 'último mês';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} semanas atrás';
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
