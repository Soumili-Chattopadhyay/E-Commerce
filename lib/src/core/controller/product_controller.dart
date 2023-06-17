

import 'dart:convert';

import 'package:e_commerce/src/common/constants/constants.dart';
import 'package:e_commerce/src/core/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class ProductController extends GetxController{
  Rxn<ProductModel> productModel = Rxn<ProductModel>();
  Rx<List<ProductModel>> allProducts = Rx<List<ProductModel>>([]);

  List<ProductModel> get getAllProducts => allProducts.value;


  Future<void> getProducts() async {
    final Uri productUri = Uri.https(AppConstants.BASEURL, AppConstants.API_PATH);

    try {
      final response = await http.get(productUri);
      final List<dynamic> products = jsonDecode(response.body);
      final List<ProductModel> productList = products.map((element) => ProductModel.fromJson(element)).toList();
      allProducts.value = productList;
    } catch (e) {
      dev.log(e.toString());
    }
  }
}