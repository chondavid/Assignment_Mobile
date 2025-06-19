import 'package:dio/dio.dart';
import 'package:full_stack_app_ecom/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

import '../../../data/models/product.model.dart';

class SearchProductController extends GetxController {
  final _provider = Get.find<APIProvider>();
  var products = <Products>[].obs;
  var isLoading = false.obs;
  RxBool isSearch = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    // searchProduct();
    super.onInit();
  }

  void searchProduct(
      {String? search, double? minPrice, double? maxPrice}) async {
    try {
      isLoading(true);
      final response = await _provider.searchProduct(
          search: search, maxPrice: maxPrice, minPrice: minPrice);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("Data: $data");
        if (data.isNotEmpty) {
          products.value = data.map((json) => Products.fromJson(json)).toList();
        } else {
          products.value = [];
        }
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } on DioException catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
