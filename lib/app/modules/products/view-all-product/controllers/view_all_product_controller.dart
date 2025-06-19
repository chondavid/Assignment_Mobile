import 'package:full_stack_app_ecom/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

import '../../../../data/models/product.model.dart';

class ViewAllProductController extends GetxController {
  final _apiProvider = Get.find<APIProvider>();
  var products = <Products>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var lastPage = 1;

  @override
  void onInit() {
    fetchProduct(currentPage.value);
    super.onInit();
  }

  void fetchProduct(int pageNum) async {
    final id = Get.arguments;

    try {
      final response = await _apiProvider.getProductByCate(
          proId: id, pageNum: currentPage.value);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        if (data.isNotEmpty) {
          products.addAll(data.map((e) => Products.fromJson(e)).toList());
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void loadMoreProducts() {
    if (currentPage.value < lastPage) {
      currentPage.value++;
      fetchProduct(currentPage.value);
    }
  }
}
