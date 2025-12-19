import 'package:get/get.dart';

class HomeController extends GetxController {
  final bottomNavIndex = 0.obs;

  void changeTabIndex(int index) {
    bottomNavIndex.value = index;
  }
}
