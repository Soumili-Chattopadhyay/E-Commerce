import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:e_commerce/src/views/dashboard/fav/favorites.dart';
import 'package:e_commerce/src/views/dashboard/wishlist/wishlist.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<BottomNavigationBarItem> _bottomNavBarItems =
      <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_rounded),
      label: 'All',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_basket),
      label: 'Wishlist',
    ),
  ];
  int _selectIndex = 1;
  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _dashboardOptions = <Widget>[
    const Favorites(),
    const All(),
    const Wishlist(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF3C486B),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(500.0),
            topRight: Radius.circular(50.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            selectedIconTheme: const IconThemeData(
              size: 50.0,
              color: Colors.white,
            ),
            unselectedItemColor: Colors.white54,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            items: _bottomNavBarItems,
            currentIndex: _selectIndex,
            onTap: _onItemTap,
          ),
        ),
      ),
      body: _dashboardOptions.elementAt(_selectIndex),
    );
  }
}
