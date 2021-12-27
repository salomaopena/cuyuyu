//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/common/custom_icon_button.dart';
import 'package:cuyuyu/src/models/category/category_manager.dart';
import 'package:cuyuyu/src/models/category/product_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryEditScreen extends StatelessWidget {
  CategoryEditScreen({this.category});

  ProductCategory category;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(
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
          child: Consumer<CategoryManager>(
              builder: (_, CategoryManager categoryManager, __) {
            return Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          progressIndicatorBuilder:
                              (_, __, DownloadProgress downloadProgress) =>
                                  Center(
                                      child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.deepOrange),
                          )),
                          errorWidget: (_, __, ___) => const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16))),
                            padding: const EdgeInsets.all(8),
                            child: CustomIconButton(
                              icon: Icons.add_a_photo,
                              color: Colors.deepOrange,
                              size: 32,
                              onTap: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: category.name,
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
                    onSaved: (name) => category.name = name,
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
                    onPressed: () async{
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        await categoryManager.saveCategory(
                            category: category,
                            onSuccess: () {
                              //TODO: Implement success
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
              ),
            );
          }),
        ),
      ),
    );
  }
}
