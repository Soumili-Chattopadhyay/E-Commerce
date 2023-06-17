import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:e_commerce/src/core/controller/product_controller.dart';
import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/preferences/user_preference.dart';
import 'package:e_commerce/src/core/routes/routes.dart';
import 'package:e_commerce/src/views/dashboard/product_details/product_details.dart';
import '../../../common/constants/constants.dart';
import '../../../common/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<dynamic> favProduct = [];
dynamic userIs;
List name = [];

enum Filters {
  normal,
  highToLow,
  lowToHigh,
}

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController _userController =
      Get.find(tag: AppConstants.kUserController);
  final UserPreference _userPreference = UserPreference();
  final ProductController _productController =
      Get.find(tag: AppConstants.kProductController);
  dynamic currentUser;
  bool gotUser = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool likeProduct = false;

  bool? loading;
  List customProducts = [];

  List<String> drawerElements = ['My Profile', 'My Cart', 'My Orders'];

  Filters filter = Filters.normal;
  void marketView() {
    if (filter == Filters.normal) {
      customProducts = _productController.getAllProducts;
    } else if (filter == Filters.highToLow) {
      dynamic temp;
      for (int i = 0; i < customProducts.length; i++) {
        for (int j = i + 1; j < customProducts.length; j++) {
          if (customProducts[i].price! < customProducts[j].price!) {
            temp = customProducts[i];
            customProducts[i] = customProducts[j];
            customProducts[j] = temp;
          }
        }
      }
    } else if (filter == Filters.lowToHigh) {
      dynamic temp;
      for (int i = 0; i < customProducts.length; i++) {
        for (int j = i + 1; j < customProducts.length; j++) {
          if (customProducts[i].price! > customProducts[j].price!) {
            temp = customProducts[i];
            customProducts[i] = customProducts[j];
            customProducts[j] = temp;
          }
        }
      }
    }
  }

  void currentUserStatus() async {
    currentUser = await _userPreference.getUser();
    setState(() {
      gotUser = true;
    });

    userIs = (gotUser) ? currentUser : _userController.getUser;
    // log('userIs::${userIs.toString()}');
    name = userIs[2].split('@');
    userdb.doc(userIs[0]).get().then(
      (value) async {
        dynamic temp = jsonEncode(value.data());
        dynamic temp2 = jsonDecode(temp);
        favProduct = temp2['favorites'];
        myWishlist = temp2['wishlist'];
        myCart = temp2['cart'];
        boughtItems = temp2['bought'];
        await _productController.getProducts();
        if (myWishlist.isEmpty) {
          for (int i = 0; i < customProducts.length; i++) {
            myWishlist.add(false);
          }
          // log('lk:${myWishlist.toString()}');
        }
      },
    );
  }

  @override
  void initState() {
    currentUserStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).canvasColor,
      drawer: SafeArea(
        child: Container(
          height: 300.0,
          width: 150.0,
          margin: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
          padding: const EdgeInsets.only(top: 75.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: Drawer(
            elevation: 12.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
            child: Center(
              child: ListView(
                children: <Widget>[
                  for (int i = 0; i < drawerElements.length; i++)
                    InkWell(
                      onTap: () {
                        if (drawerElements[i] == 'My Orders') {
                          Navigator.of(context).pushNamed(AppRoutes.myOrders);
                          _scaffoldKey.currentState?.closeDrawer();
                        }
                        if (drawerElements[i] == 'My Cart') {
                          Navigator.of(context).pushNamed(AppRoutes.cart);
                          _scaffoldKey.currentState?.closeDrawer();
                        }
                        if (drawerElements[i] == 'My Profile') {
                          Navigator.of(context).pushNamed(AppRoutes.profile);
                          _scaffoldKey.currentState?.closeDrawer();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 30.0, 0.0),
                        height: 75.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.25),
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            drawerElements[i],
                            style: const TextStyle(
                              fontFamily: 'Fredoka',
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).highlightColor,
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              shadowColor: Theme.of(context).highlightColor.withOpacity(0.1),
              actions: <Widget>[
                PopupMenuButton(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.white,
                  shadowColor: Theme.of(context).highlightColor,
                  itemBuilder: (context) {
                    return <PopupMenuItem>[
                      PopupMenuItem(
                        onTap: () {
                          setState(() {
                            filter = Filters.normal;
                          });
                        },
                        child: const Text(
                          'Price: Normal',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          setState(() {
                            filter = Filters.highToLow;
                          });
                        },
                        child: const Text(
                          'Price: High to Low',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          setState(() {
                            filter = Filters.lowToHigh;
                          });
                        },
                        child: const Text(
                          'Price: Low to High',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ];
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: _productController.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: SizedBox(
                    height: 25.0,
                    width: 25.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).canvasColor,
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              marketView();
              return GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  for (int i = 0; i < customProducts.length; i++)
                    CustomProductCard(
                      onCardTap: () async {
                        // log('tapped');

                        Navigator.pushNamed(context, AppRoutes.productDetails,
                            arguments: customProducts[i]);
                      },
                      productImage: customProducts[i].image!,
                      productTitle: customProducts[i].title!,
                      productPrice: customProducts[i].price!,
                      likedProduct:
                          (favProduct.isNotEmpty) ? favProduct[i] : false,
                      onLikeTap: () {
                        if (favProduct.isEmpty) {
                          for (int i = 0; i < customProducts.length; i++) {
                            favProduct.add(false);
                            // log('ok');
                          }
                        }
                        setState(() {
                          favProduct[i] = !favProduct[i];
                        });
                        // log(favProduct.toString());
                        userdb.doc(userIs[0]).update({'favorites': favProduct});
                        // userdb
                        //     .doc(userIs[0])
                        //     .get()
                        //     .then((value) => log(value.data().toString()));
                      },
                    ),
                ],
              );
            }
            return Container();
          }),
    );
  }
}
