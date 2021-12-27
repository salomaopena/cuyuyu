//@dart=2.9
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/models/category/category_manager.dart';
import 'package:cuyuyu/src/models/category/product_category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CategoryAddScreen extends StatefulWidget {
  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  UploadTask task;
  File fileUrl;

  @override
  Widget build(BuildContext context) {
    final fileName =
        fileUrl != null ? basename(fileUrl.path) : 'Seleccione uma image';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova categoria',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Form(
            key: formKey,
            child: Consumer<CategoryManager>(
                builder: (_, CategoryManager categoryManager, __) {
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (fileUrl != null)
                          Image.file(
                            fileUrl,
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 32,
                            ),
                          )
                        else
                          Center(
                              child: Container(
                            child: (fileUrl == null) ? Text(fileName) : null,
                          )),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16))),
                            padding: const EdgeInsets.all(8),
                            child: CustomIconButton(
                              icon: Icons.add_photo_alternate_rounded,
                              color: Colors.deepOrange,
                              size: 32,
                              onTap: selectFile,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    enabled: !categoryManager.loading,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Nome',
                      labelText: 'Nome',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Campo obrigatório';
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
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        await categoryManager.addCategory(
                            file: fileUrl,
                            category:
                                ProductCategory(name: nameController.text),
                            onSuccess: () {
                              Flushbar(
                                title: 'Sucesso',
                                message: 'Dados cadastrados com sucesso',
                                flushbarPosition: FlushbarPosition.TOP,
                                flushbarStyle: FlushbarStyle.GROUNDED,
                                isDismissible: true,
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: const Duration(seconds: 5),
                                icon:
                                    const Icon(Icons.save, color: Colors.white),
                              ).show(context);
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Erro ao alterar dados $error'),
                                backgroundColor: AppColors.redColor,
                              ));
                            });
                      }
                    },
                    child: !categoryManager.loading
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    await Permission.photos.request();
    final PermissionStatus permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      final FilePickerResult result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowMultiple: false,
        type: FileType.image,
      );

      if (result == null) return;
      final String path = result.files.single.path;
      setState(() => fileUrl = File(path));
    } else {
      print('Grant Permissions and try again');
    }
  }
}
