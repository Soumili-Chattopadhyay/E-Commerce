import 'package:e_commerce/src/views/dashboard/product_details/product_details.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List items = [];

  int count = 1;

  @override
  void initState() {
    // List items = boughtItems.map((e) => ProductModel.fromJson(e)).toList();
    // log(items.toString());
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
          'My Orders',
          style: TextStyle(
                  color: Colors.white,
                ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < boughtItems.length; i++)
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              leading: SizedBox(
                height: 50.0,
                width: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      boughtItems[i]['image'],
                    ),
                  ),
                ),
              ),
              title: Text(
                boughtItems[i]['product'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('\$${boughtItems[i]['price']}'),
              trailing: SizedBox(
                height: 20.0,
                width: 25.0,
                child: Text(
                  '${boughtItems[i]['count']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
