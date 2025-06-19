import 'package:get/get.dart';
import '../modules/addresses/add-address/bindings/add_address_binding.dart';
import '../modules/addresses/add-address/views/add_address_view.dart';
import '../modules/addresses/address/bindings/address_binding.dart';
import '../modules/addresses/address/views/address_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/edit-profile/bindings/edit_profile_binding.dart';
import '../modules/edit-profile/views/edit_profile_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/manage-account/bindings/manage_account_binding.dart';
import '../modules/manage-account/views/manage_account_view.dart';
import '../modules/products/home/bindings/home_binding.dart';
import '../modules/products/home/views/home_view.dart';
import '../modules/products/product-detail/bindings/product_detail_binding.dart';
import '../modules/products/product-detail/views/product_detail_view.dart';
import '../modules/products/view-all-product/bindings/view_all_product_binding.dart';
import '../modules/products/view-all-product/views/view_all_product_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search-product/bindings/search_product_binding.dart';
import '../modules/search-product/views/search_product_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  // static const INITIAL = Routes.LOGIN;
  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    // GetPage(
    //   name: _Paths.PRODUCT_DETAIL,
    //   page: () => const ProductDetailView(),
    //   binding: ProductDetailBinding(),
    // ),
    GetPage(
      name: _Paths.VIEW_ALL_PRODUCT,
      page: () => ViewAllProductView(),
      binding: ViewAllProductBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_ACCOUNT,
      page: () => const ManageAccountView(),
      binding: ManageAccountBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => const AddAddressView(),
      binding: AddAddressBinding(),
    ),
  ];
}
