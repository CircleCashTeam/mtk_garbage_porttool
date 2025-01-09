import 'package:get/get.dart';

class BaseItemController extends GetxController {
  Rx<String> baseSystemImagePath = "".obs;
  Rx<String> baseBootImagePath = "".obs;

  void setSystemImagePath(String path) {
    baseSystemImagePath.value = path;
  }

  void setBootImagePath(String path) {
    baseBootImagePath.value = path;
  }

  String getSystemImagePath() {
    return baseSystemImagePath.value;
  }

  String getBootImagePath() {
    return baseBootImagePath.value;
  }
}
