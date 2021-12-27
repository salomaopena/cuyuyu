//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:cuyuyu/src/models/category/category_manager.dart';
import 'package:cuyuyu/src/models/category/product_category.dart';
import 'package:cuyuyu/src/models/users/user_manager.dart';
import 'package:cuyuyu/src/pages/category/category_add_screen.dart';
import 'package:cuyuyu/src/pages/category/category_edit_screen.dart';
import 'package:cuyuyu/src/pages/home/components/custom_drawer.dart';
import 'package:cuyuyu/src/pages/product_category/product_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Categoria de produto',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          Consumer<UserManager>(builder: (_, userManager, __) {
            if (userManager.adminEnabled) {
              return IconButton(
                onPressed: () {
                  Get.to(() => CategoryAddScreen());
                },
                icon: const Icon(Icons.add, color: AppColors.closeColor),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
      body: Consumer2<CategoryManager, UserManager>(
        builder: (_, categoryManager, userManager, __) {
          final List<ProductCategory> categories = categoryManager.categories;
          return ListView.separated(
              itemCount: categories.length,
              itemBuilder: (_, int index) {
                final ProductCategory category = categories[index];
                return GestureDetector(
                  onTap: () =>
                      Get.to(() => ProductCategoryScreen(category: category)),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 0,
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: category.imageUrl,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                            progressIndicatorBuilder:
                                (_, __, DownloadProgress downloadProgress) =>
                                    Center(
                                        child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: const AlwaysStoppedAnimation(
                                  Colors.deepOrange),
                            )),
                            errorWidget: (_, __, ___) => Image.asset(
                              'images/app_logo.png',
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.nearlyBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        trailing: userManager.adminEnabled
                            ? PopupMenuButton(
                                enableFeedback: true,
                                onSelected: (e) {
                                  if (e == 'Alterar') {
                                    Get.to(() =>
                                        CategoryEditScreen(category: category));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('Excluir'),
                                            content: category != null
                                                ? ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: CachedNetworkImage(
                                                      imageUrl:
                                                          category.imageUrl,
                                                      fit: BoxFit.cover,
                                                      filterQuality:
                                                          FilterQuality.medium,
                                                      width: 70,
                                                      height: 70,
                                                      progressIndicatorBuilder: (_,
                                                              __,
                                                              DownloadProgress
                                                                  downloadProgress) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation(
                                                                Colors
                                                                    .deepOrange),
                                                      )),
                                                      errorWidget:
                                                          (_, __, ___) =>
                                                              Image.asset(
                                                        'images/app_logo.png',
                                                        repeat: ImageRepeat
                                                            .noRepeat,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    title: Text(category.name,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    subtitle: Text(
                                                      'Esta acção não poderá ser desfeita',
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.red,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  await categoryManager
                                                      .deleteCategory(
                                                          category: category);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  }
                                },
                                itemBuilder: (_) {
                                  return ['Alterar', 'Excluir'].map((e) {
                                    return PopupMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              color: e.contains('Excluir')
                                                  ? Colors.red
                                                  : Colors.black),
                                        ));
                                  }).toList();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, int index) => const SizedBox(height: 8));
        },
      ),
    );
  }
}
