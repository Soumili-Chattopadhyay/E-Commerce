import 'package:e_commerce/src/common/constants/constants.dart';
import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController _userController =
      Get.find(tag: AppConstants.kUserController);
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
          'My Profile',
          style: TextStyle(
                  color: Colors.white,
                ),
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
              child: const Image(
                image: AssetImage(
                  'asset/image/profile.jpg',
                ),
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Text(
              name[0],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0,),
            Text(
              '${name[0]}@${name[1]}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            InkWell(
              onTap: () async {
                final int getValue = await _userController.signOut();
                if (getValue == 0) {
                  return;
                }
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/authLogin');
                }
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
