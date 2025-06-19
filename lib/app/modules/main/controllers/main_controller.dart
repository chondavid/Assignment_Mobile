import 'package:flutter/cupertino.dart';
import 'package:full_stack_app_ecom/app/modules/cart/bindings/cart_binding.dart';
import 'package:full_stack_app_ecom/app/modules/cart/views/cart_view.dart';
import 'package:full_stack_app_ecom/app/modules/edit-profile/bindings/edit_profile_binding.dart';
import 'package:full_stack_app_ecom/app/modules/edit-profile/views/edit_profile_view.dart';
import 'package:full_stack_app_ecom/app/modules/manage-account/bindings/manage_account_binding.dart';
import 'package:full_stack_app_ecom/app/modules/manage-account/views/manage_account_view.dart';
import 'package:full_stack_app_ecom/app/modules/profile/bindings/profile_binding.dart';
import 'package:full_stack_app_ecom/app/modules/profile/views/profile_view.dart';
import 'package:full_stack_app_ecom/app/modules/search-product/bindings/search_product_binding.dart';
import 'package:full_stack_app_ecom/app/modules/search-product/views/search_product_view.dart';
import 'package:full_stack_app_ecom/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../products/home/bindings/home_binding.dart';
import '../../products/home/views/home_view.dart';

class MainController extends GetxController {
  final pages = <String>[
    Routes.HOME,
    Routes.SEARCH_PRODUCT,
    Routes.CART,
    Routes.MANAGE_ACCOUNT
  ];
  var currentIndex = 0.obs;

  void onTab(index) {
    if (currentIndex == index) return;
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 1);
  }

  //TODO: Implement MainController
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => HomeView(),
        binding: HomeBinding(),
      );
    }
    if (settings.name == Routes.SEARCH_PRODUCT) {
      return GetPageRoute(
        settings: settings,
        transition: Transition.fadeIn,
        page: () => SearchProductView(),
        binding: SearchProductBinding(),
      );
    }
    if (settings.name == Routes.CART) {
      return GetPageRoute(
        settings: settings,
        page: () => CartView(),
        binding: CartBinding(),
      );
    }
    if (settings.name == Routes.MANAGE_ACCOUNT) {
      return GetPageRoute(
        settings: settings,
        page: () => ManageAccountView(),
        binding: ManageAccountBinding(),
      );
    }
    if (settings.name == Routes.EDIT_PROFILE) {
      return GetPageRoute(
        settings: settings,
        page: () => EditProfileView(),
        binding: EditProfileBinding(),
      );
    }
  }
}
