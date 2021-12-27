//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/social_button.dart';
import 'package:cuyuyu/src/common/validators.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/models/users/user_model.dart';
import 'package:cuyuyu/src/pages/reset_password/reset_password_screen.dart';
import 'package:cuyuyu/src/pages/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
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
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: AppColors.closeColor,
                  ),
                  const SizedBox(height: 16),
                  if (!userManager.googleLoading) ...[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'E-mail',
                        hintText: 'E-mal',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autofocus: true,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido!';
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
                      enabled: !userManager.loading,
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
                      obscureText: userManager.obscuredText,
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
                    Row(
                      children: [
                        Flexible(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Get.to(()=>SignUpScreen(),transition: Transition.zoom);
                              },
                              child: const Text(
                                "Criar conta",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              )),
                        )),
                        Flexible(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>Get.to(()=>ResetPasswordScreen()),
                              child: const Text(
                                "Esqueci a minha senha",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          userManager.sigIn(
                              user: UserModel(
                                userMail: emailController.text,
                                password: passwordController.text,
                              ),
                              onFail: (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Falha ao iniciar sessão: $e"),
                                  backgroundColor: AppColors.redColor,
                                ));
                              },
                              onSuccess: () {
                                Navigator.of(context).pop();
                              });
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
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  const Text(
                    'OU',
                    style: TextStyle(
                      fontSize: 16
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SocialButton(
                      icon: FontAwesomeIcons.google,
                      color: Colors.white,
                      background: AppColors.cuyutyuBlue,
                      text: !userManager.googleLoading
                          ? 'Entrar com o google'
                          : 'Aguarde...',
                      onPressed: () async {
                        await userManager.signInWithGoogle(onFail: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Falha ao iniciar sessão: $error"),
                            backgroundColor: AppColors.redColor,
                          ));
                        }, onSuccess: () {
                          Get.back(canPop: true);
                        });
                      }),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
