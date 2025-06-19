import 'package:full_stack_app_ecom/app/data/models/cart.res.model.dart';
import 'package:full_stack_app_ecom/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/providers/api_provider.dart';

class CartController extends GetxController {
  final _provider = Get.find<APIProvider>();
  var isLoading = false.obs;
  Rx<CartResponse> cart = Rx(CartResponse());
  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  void fetchCart() async {
    try {
      isLoading(true);
      final response = await _provider.getCartProducts();
      print("response cart ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = response.data;
        cart.value = CartResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        Get.toNamed(Routes.LOGIN);
      } else {}
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
}
