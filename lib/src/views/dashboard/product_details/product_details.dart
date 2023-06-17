import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/models/product_model.dart';
import 'package:e_commerce/src/core/routes/routes.dart';
import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:flutter/material.dart';

List<dynamic> myWishlist = [];
List<dynamic> myCart = [];
List<dynamic> boughtItems = [];

class ProductDetails extends StatefulWidget {
  ProductModel? productModel;
  ProductDetails({
    required this.productModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int rating = 0;
  int available = 0;
  int count = 1;

  @override
  void initState() {
    final rate = widget.productModel!.rate;
    rating = rate!.toInt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: BackButton(
          color: Theme.of(context).highlightColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  myWishlist[widget.productModel!.id! - 1] =
                      !myWishlist[widget.productModel!.id! - 1];
                  
                });
                userdb.doc(userIs[0]).update({'wishlist': myWishlist});
              },
              child: (myWishlist[widget.productModel!.id! - 1])
                  ? Icon(
                      Icons.shopping_bag,
                      size: 30.0,
                      color: Theme.of(context).highlightColor,
                    )
                  : Icon(
                      Icons.shopping_bag_outlined,
                      size: 30.0,
                      color: Theme.of(context).highlightColor,
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  height: 200.0,
                  child: Center(
                    child: Image(
                      image: NetworkImage(
                        widget.productModel!.image!,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  child: Text(
                    widget.productModel!.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    '\$${widget.productModel!.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Icon>[
                          for (int i = 0; i < rating; i++)
                            Icon(
                              Icons.star,
                              color: Theme.of(context).highlightColor,
                            ),
                        ] +
                        [
                          for (int i = 0; i < 5 - rating; i++)
                            Icon(
                              Icons.star,
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.25),
                            ),
                        ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  width: double.maxFinite,
                  // height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.8, 1.0],
                      colors: [
                        Theme.of(context).canvasColor,
                        Colors.white,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.25),
                        blurRadius: 2.0,
                        spreadRadius: 0,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: Text(
                          widget.productModel!.description!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.5,
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 28.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Category',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              (widget.productModel!.category!),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  if (count > 0) {
                                    setState(() {
                                      count--;
                                    });
                                  }
                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 25.0,
                                )),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              ('$count'),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: 50.0,
                              width: 150.0,
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    {
                                      myCart.add({
                                        'product': widget.productModel!.title,
                                        'image': widget.productModel!.image,
                                        'price': widget.productModel!.price,
                                        'count': count,
                                      });
                                    }
                                  });
                                  userdb
                                      .doc(userIs[0])
                                      .update({'cart': myCart});

                                  Navigator.pushNamed(context, AppRoutes.cart);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Theme.of(context).canvasColor,
                                elevation: 12.0,
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 50.0,
                              width: 150.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    {
                                      boughtItems.add({
                                        'product': widget.productModel!.title,
                                        'image': widget.productModel!.image,
                                        'price': widget.productModel!.price,
                                        'count': count,
                                      });
                                    }
                                  });
                                  userdb
                                      .doc(userIs[0])
                                      .update({'bought': boughtItems});

                                  Navigator.pushNamed(
                                      context, AppRoutes.myOrders);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Theme.of(context).highlightColor,
                                elevation: 12.0,
                                child: Text(
                                  'BUY NOW',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
