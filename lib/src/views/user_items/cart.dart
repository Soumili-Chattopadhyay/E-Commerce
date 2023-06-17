import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/routes/routes.dart';
import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:e_commerce/src/views/dashboard/product_details/product_details.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  num count = 0;
  double cost = 0;

  @override
  void initState() {
    for (int i = 0; i < myCart.length; i++) {
      setState(() {
        count += myCart[i]['count'];
        cost += myCart[i]['price'] * myCart[i]['count'];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)
          ),
        ),
        backgroundColor: Theme.of(context).highlightColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Cart',
          style: TextStyle(
                  color: Colors.white,
                ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < myCart.length; i++)
                    Container(
                      margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
                      height: 150.0,
                      width: double.maxFinite,
                      color: Colors.transparent,
                      child: Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image: NetworkImage(
                                    myCart[i]['image'],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        16.0, 20.0, 8.0, 20.0),
                                    height: 40.0,
                                    child: Text(
                                      myCart[i]['product'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 0.0, 8.0, 0.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('\$${myCart[i]['price']}'),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              myCart[i]['count'] -= 1;
                                              count--;
                                              cost -= myCart[i]['price'];
                                              if (myCart[i]['count'] == 0) {
                                                myCart.remove(myCart[i]);
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            size: 25.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          ('${myCart[i]['count']}'),
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .highlightColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              myCart[i]['count'] += 1;
                                              count++;
                                              cost += myCart[i]['price'];
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            size: 25.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 125.0,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 125.0,
                width: double.maxFinite,
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
                      color: Theme.of(context).highlightColor.withOpacity(0.25),
                      blurRadius: 2.0,
                      spreadRadius: 0,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  height: 100.0,
                  width: double.maxFinite,
                  child: Column(
                    children: <Widget>[
                      const Row(
                        children: <Widget>[
                          Text(
                            'Total items',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Total cost',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '$count',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${cost.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 150.0,
                          child: MaterialButton(
                            onPressed: () async {
                              setState(() {
                                for(int i=0; i<myCart.length; i++){
                                  boughtItems.add(myCart[i]);
                                }
                                myCart = [];
                                count = 0;
                                cost = 0;
                              });
                              userdb.doc(userIs[0]).update({
                                'bought': boughtItems,
                                'cart': myCart,
                              });

                              Navigator.pushNamed(context, AppRoutes.myOrders);
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
