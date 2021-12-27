//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/validators.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar a senha',
            style: TextStyle(
                color: AppColors.closeColor,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
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
                    Icon(
                      Icons.account_circle,
                      size: 80,
                      color: AppColors.closeColor,
                    ),
                    SizedBox(height: 16),
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
                          formKey.currentState.save();
                          userManager.resetPassword(
                            email: emailController.text,
                            onError: (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Um erro foi detectado. Porfavor reveja as informações: $e'),
                                backgroundColor: AppColors.redColor,
                              ));
                            },
                            onSuccess: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Foi enviado um correio de recuperação para ${emailController.text}'),
                                backgroundColor: AppColors.redColor,
                                duration: const Duration(seconds: 10),
                                action: SnackBarAction(
                                  onPressed: () => Get.offAll(() => BaseScreen()),
                                  label: 'Fechar',
                                ),
                              ));
                            },
                          );
                        }
                      },
                      child: !userManager.loading
                          ? const Text("Enviar",
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
                    )
                  ]);
            }),
          ),
        ),
      ),
    );
  }
}
