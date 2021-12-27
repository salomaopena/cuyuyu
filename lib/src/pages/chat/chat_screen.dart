//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/chat/chat_manager.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/chat/components/message_card.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/login/components/login_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer2<ChatManager, UserManager>(
          builder: (_, ChatManager chatManager, userManager, __) {
        if (!userManager.isLoggedIn) {
          return const LoginCard();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              if (chatManager.messages.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Olá, ${userManager.user.userName}! Em que podemos ajudar?',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                    child: ListView.separated(
                  itemCount: chatManager.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = chatManager.messages[index];
                    final bool isMe = message.userId == userManager.user.userId;
                    return MessageCard(
                        message: message, isMe: isMe, user: userManager.user);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 8),
                )),
              const Divider(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: editingController,
                          autofocus: true,
                          textCapitalization: TextCapitalization.sentences,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Informe sua situação',
                            isDense: true,
                            focusedBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 1.3,
                            letterSpacing: 1.1,
                            color: AppColors.nearlyBlack,
                            height: 1.2,
                          ),
                          initialValue: null,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe sua situação, por favor.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      iconSize: 25,
                      color: AppColors.closeColor,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          await chatManager.sendMessage(
                              userManager.user, editingController.text);
                          _formKey.currentState.reset();
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
