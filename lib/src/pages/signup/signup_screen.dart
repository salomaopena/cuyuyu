//@dart=2.9

import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/validators.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:cuyuyu/src/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar conta',
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
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (_, UserManager userManager, __) {
              return ListView(
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
                    controller: nameController,
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
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
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
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
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
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: userManager.obscuredText,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Password',
                      hintText: 'Password',
                      isDense: true,
                      suffixIcon: GestureDetector(
                        onTap: () => userManager.obscuredText =
                            !userManager.obscuredText,
                        child: Icon(userManager.obscuredText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return 'Preenchimento obrigatório!';
                      }
                      if (password.trim().length < 8) {
                        return 'A senha não pode ser menor de 8 caracteres';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: password2Controller,
                    obscureText: userManager.obscuredText,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Confirmar password',
                      hintText: 'Confirmar password',
                      isDense: true,
                      suffixIcon: GestureDetector(
                        onTap: () => userManager.obscuredText =
                            !userManager.obscuredText,
                        child: Icon(userManager.obscuredText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: (password2) {
                      if (password2 == null || password2.trim().isEmpty) {
                        return 'Preenchimento obrigatório!';
                      }
                      if (password2.trim().length < 8) {
                        return 'A senha não pode ser menor de 8 caracteres';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
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
                        if (passwordController.text !=
                            password2Controller.text) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Senha não coincidem"),
                            backgroundColor: AppColors.redColor,
                          ));
                          return;
                        }

                        userManager.signUp(
                          userModel: UserModel(
                            userName: nameController.text,
                            userMail: emailController.text,
                            userPhoneNumber: phoneController.text,
                            password: passwordController.text,
                          ),
                          onFail: (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Falha ao criar conta: $e"),
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
                        ? const Text("Iniciar sessão",
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
                  SizedBox(height: 16),
                  TextButton(
                      onPressed: () {
                        Get.back(canPop: true);
                      },
                      child: Text(
                        "Já tenho uma conta",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: AppColors.redColor,
                        elevation: 0,
                        padding: const EdgeInsets.all(16),
                        enableFeedback: true,
                        onSurface: Colors.grey[700],
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
