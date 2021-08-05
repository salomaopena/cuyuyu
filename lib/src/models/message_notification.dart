//@dart=2.9
import 'package:flutter/foundation.dart';

@immutable
class Message {
  final String title;
  final String body;

  Message({@required this.title, @required this.body});
}
