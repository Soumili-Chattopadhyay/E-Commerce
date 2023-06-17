import 'package:e_commerce/src/core/controller/product_controller.dart';
import 'package:e_commerce/src/core/controller/user_controller.dart';
import 'package:e_commerce/src/common/constants/constants.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings{
  @override
  void dependencies(){
    Get.put(UserController(), tag: AppConstants.kUserController);
    Get.put(ProductController(), tag: AppConstants.kProductController);
  }
}