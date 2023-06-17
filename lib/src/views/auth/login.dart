import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/utils/pump_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/custom_textfield_1.dart';
import '../../common/widgets/custom_button_1.dart';
import '../../common/constants/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserController userController =
      Get.find(tag: AppConstants.kUserController);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  final OverlayEntry _loadingOverlay = OverlayEntry(
    builder: ((context) {
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black45,
        child: const Center(
          child: SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      );
    }),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('asset/image/login.png'),),
                  ),
                ),
                Form(
                  key: _emailFormKey,
                  child: CustomTextField1(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    editingController: emailController,
                    labelText: 'Enter your email',
                  ),
                ),
                Form(
                  key: _passwordFormKey,
                  child: CustomTextField1(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    editingController: passwordController,
                    labelText: 'Enter your password',
                  ),
                ),
                CustomButton1(
                  onTap: () async {
                    Overlay.of(context).insert(_loadingOverlay);
                    final int getValue =
                        await userController.signInWithEmailandPassword(
                            emailController.text, passwordController.text);
                    if (mounted && getValue != 1) {
                      switch (getValue) {
                        case 2:
                          pumpNotification(
                            PumpNotificationType.error,
                            message: 'No user found for that email.',
                          );
          
                          break;
                        case 3:
                          pumpNotification(
                            PumpNotificationType.error,
                            message: 'Wrong password provided for that user.',
                          );
          
                          break;
          
                        case 4:
                          pumpNotification(
                            PumpNotificationType.error,
                            message: 'Please check the network connection.',
                          );
          
                          break;
          
                        case 5:
                          pumpNotification(
                            PumpNotificationType.error,
                            message: 'Please fill your details properly.',
                          );
                      }
                      _loadingOverlay.remove();
                      return;
                    }
          
                    if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
                    _loadingOverlay.remove();
                  },
                  borderColor: Colors.transparent,
                  borderWidth: 0.0,
                  buttonHeight: 45.0,
                  buttonWidth: 100.0,
                  childText: 'Login',
                  bodyColor: Theme.of(context).highlightColor,
                  childTextColor: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                  child: Text(
                    'or',
                    textScaleFactor: 2.5,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  width: 200.0,
                  child: Center(
                    child: CustomButton1(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      borderColor: Theme.of(context).highlightColor,
                      borderWidth: 1.5,
                      buttonHeight: 50.0,
                      buttonWidth: 150.0,
                      childText: 'Sign up',
                      childTextColor: Theme.of(context).highlightColor,
                    ),
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
