import 'package:full_stack_app_ecom/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

class APIBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(APIProvider(), permanent: true);
  }
}
