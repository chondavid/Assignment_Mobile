import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_app_ecom/app/data/models/product.model.dart';
import 'package:full_stack_app_ecom/app/data/providers/api_provider.dart';
import 'package:full_stack_app_ecom/app/modules/products/product-detail/views/product_detail_view.dart';
import 'package:full_stack_app_ecom/app/routes/app_pages.dart';
import 'package:full_stack_app_ecom/app/services/storage_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _apiProvider = Get.find<APIProvider>();
  var isLoading = false.obs;
  Rx<Product> products = Product().obs;

  var currentUser;

  @override
  void onInit() {
    getCurrentUserLoggedIn();
    fetchProduct();
    super.onInit();
  }

  void getCurrentUserLoggedIn() async {
    final user = await StorageService.read(key: 'user');
    currentUser = user;
    print('user $user');
  }

  void fetchProduct() async {
    try {
      final response = await _apiProvider.getProducts();
      if (response.statusCode != 200) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to get product",
        );
      }

      products.value = Product.fromJson(response.data);
      print("product ${response.data}");
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
      );
    } finally {}
  }

  void goToDetail(Products product) {
    Get.to(() => ProductDetailView(
          product: product,
        ));
  }

  void addToCart(
      {required int productId,
      required int quantity,
      required num price}) async {
    try {
      final response = await _apiProvider.addToCart(
          productId: productId, quantity: quantity, price: price);
      print("response ${response.statusCode}");
      if (response.statusCode == 200) {
        // success
        Get.snackbar("Success", "Product added to cart",
            duration: Duration(seconds: 1));
      } else if (response.statusCode == 401) {
        // unautenticated
        Get.snackbar("Login", "Please login first");
        Get.toNamed(Routes.LOGIN);
        // write route name to storage device
        // Routes.PRODUCT_DETAIL
      } else {
        Get.snackbar(
          "Error",
          "Product added to cart",
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("error $e");
    } finally {}
  }
}
