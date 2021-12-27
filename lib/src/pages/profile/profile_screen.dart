//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/validators.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:cuyuyu/src/pages/login/components/login_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.closeColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Consumer<UserManager>(
              builder: (_, UserManager userManager, __) {
            return Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: AppColors.closeColor,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: userManager.user.userName,
                    enabled: !userManager.loading,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Nome completo',
                      labelText: 'Nome completo',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preeencha seu nome completo';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    onSaved: (name) => userManager.user.userName = name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: userManager.user.userMail,
                    enabled: !userManager.loading,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Email',
                      labelText: 'Email',
                      isDense: true,
                    ),
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (!emailValid(email)) {
                        return 'E-mail inválido!';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    onSaved: (email) => userManager.user.userMail = email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: userManager.user.userPhoneNumber,
                    enabled: !userManager.loading,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Telefone',
                      hintText: 'Telefone',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (phone.trim().length < 9) {
                        return 'Preeencha um telemóvel válido';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    onSaved: (phone) =>
                        userManager.user.userPhoneNumber = phone,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.all(16),
                      enableFeedback: true,
                      onSurface: Colors.grey,
                      backgroundColor: AppColors.closeColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        userManager.updateUser(
                          user: userManager.user,
                          onFail: (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Falha ao alterar dados: $e"),
                              backgroundColor: AppColors.redColor,
                            ));
                          },
                          onSuccess: () {
                            Get.back(canPop: true);
                          },
                        );
                      }
                    },
                    child: !userManager.loading
                        ? const Text("Gurdar",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                letterSpacing: 1.1))
                        : const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
