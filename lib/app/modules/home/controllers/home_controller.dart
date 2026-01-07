import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
