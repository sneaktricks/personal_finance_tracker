import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt tabIndex = 0.obs;

  final pages = <String>[
    "/",
    "/add-entry",
    "/transactions",
    "/statistics",
    "/transactions/:id",
  ];

  NavigationController();

  void setTabIndex(int index) {
    tabIndex.value = index;
    Get.toNamed(pages[index]);
  }

  void setTabIndexOff(int index) {
    tabIndex.value = index;
    Get.offNamed(pages[index]);
  }
}
