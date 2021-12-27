// ignore_for_file: import_of_legacy_library_into_null_safe
//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/chat/chat_model.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  MessageCard(
      {@required this.message, @required this.isMe, @required this.user});
  final ChatModel message;
  final bool isMe;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMe)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cuyuyuOrange100,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.zero,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(200),
                        spreadRadius: 0.1,
                        blurRadius: 0.1),
                  ],
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.nearlyBlack,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(200),
                              spreadRadius: 0.1,
                              blurRadius: 0.1),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.cuyuyuOrange100,
                        child: Text(user.userName.substring(0, 1)),
                      )),
                  const SizedBox(width: 10),
                  Text(message.dateText),
                ],
              )
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.topRight,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade100,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withAlpha(200),
                        spreadRadius: 0.1,
                        blurRadius: 0.1),
                  ],
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.nearlyBlack,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(message.dateText),
                  const SizedBox(width: 10),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(200),
                              spreadRadius: 0.1,
                              blurRadius: 0.1),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.deepOrange.shade100,
                        child: Text(user.userName.substring(0, 1)),
                      )),
                ],
              )
            ],
          ),
      ],
    );
  }
}
