import 'package:e_commerce/src/common/constants/constants.dart';
import 'package:e_commerce/src/common/widgets/custom_textfield_1.dart';
import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/core/utils/pump_notification.dart';
import '../../common/widgets/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserController userController =
      Get.find(tag: AppConstants.kUserController);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  height: 300.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('asset/image/register.png'),),
                  ),
                ),
                CustomTextField1(
                  editingController: emailController,
                  labelText: 'Enter your email',
                ),
                CustomTextField1(
                  editingController: passwordController,
                  labelText: 'Enter your password',
                ),
                const SizedBox(
                  height: 25.0,
                ),
                CustomButton1(
                  onTap: () async {
                    Overlay.of(context).insert(_loadingOverlay);
                    final int getValue =
                        await userController.registerWithEmailandPassword(
                            emailController.text, passwordController.text);
                    if (mounted && getValue != 1) {
                      switch (getValue) {
                        case 2:
                          pumpNotification(
                            PumpNotificationType.warning,
                            message: 'The password provided is too weak.',
                          );
          
                          break;
                        case 3:
                          pumpNotification(
                            PumpNotificationType.error,
                            message: 'The account already exists for that email.',
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
                            message: 'Please enter a vaid emailID.',
                          );
          
                          break;
                        case 6:
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
                  childText: 'Register',
                  bodyColor: Theme.of(context).highlightColor,
                  childTextColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
