import 'dart:developer';

import 'package:e_commerce/src/common/constants/constants.dart';
import 'package:e_commerce/src/common/widgets/custom_product_card.dart';
import 'package:e_commerce/src/core/controller/product_controller.dart';
import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/routes/routes.dart';
import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // final UserController _userController =
  //     Get.find(tag: AppConstants.kUserController);
  // final UserPreference _userPreference = UserPreference();
  final ProductController _productController =
      Get.find(tag: AppConstants.kProductController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0)),
        ),
        backgroundColor: Theme.of(context).highlightColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          for (int i = 0; i < favProduct.length; i++)
            if (favProduct[i] == true)
              CustomProductCard(
                onCardTap: () async {
                  // log('tapped');
                  Navigator.pushNamed(context, AppRoutes.productDetails, arguments: _productController.getAllProducts[i]);
                },
                productImage: _productController.getAllProducts[i].image!,
                productTitle: _productController.getAllProducts[i].title!,
                productPrice: _productController.getAllProducts[i].price!,
                likedProduct: (favProduct.isNotEmpty) ? favProduct[i] : false,
                onLikeTap: () {
                  if (favProduct.isEmpty) {
                    for (int i = 0;
                        i < _productController.getAllProducts.length;
                        i++) {
                      favProduct.add(false);
                      // log('ok');
                    }
                  }
                  setState(() {
                    favProduct[i] = !favProduct[i];
                  });
                  // log(favProduct.toString());
                  userdb.doc(userIs[0]).update({'favorites': favProduct});
                  userdb
                      .doc(userIs[0])
                      .get()
                      .then((value) => log(value.data().toString()));
                },
              ),
        ],
      ),
    );
  }
}

// CustomProductCard(
//             onCardTap: () async {
//               log('tapped');
//               Navigator.pushNamed(context, AppRoutes.productDetails);
//             },
//             productImage: _productController.getAllProducts[i].productImage,
//             productTitle: _productController.getAllProducts[i].productTitle,
//             productPrice: _productController.getAllProducts[i].productPrice,
//             likedProduct: (favProduct.isNotEmpty) ? favProduct[i] : false,
//             onLikeTap: () {
//               if (favProduct.isEmpty) {
//                 for (int i = 0;
//                     i < _productController.getAllProducts.length;
//                     i++) {
//                   favProduct.add(false);
//                   log('ok');
//                 }
//               }
//               setState(() {
//                 favProduct[i] = !favProduct[i];
//               });
//               log(favProduct.toString());
//               userdb.doc(userIs[0]).update({'favorites': favProduct});
//               userdb
//                   .doc(userIs[0])
//                   .get()
//                   .then((value) => log(value.data().toString()));
//             },
//           )