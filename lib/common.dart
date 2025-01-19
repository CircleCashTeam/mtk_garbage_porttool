import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LogController extends GetxController {
  final _logLimit = 5000;
  var log = <String>[].obs;
  final controller = TextEditingController();
  final scrollController = ScrollController();

  void addlog(String message) {
    while (log.length > _logLimit) {
      log.removeAt(0);
    }
    log.add(message);
    updateLogDisplay();
  }

  void clear() {
    log.clear();
  }

  void updateLogDisplay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = log.join("\n");
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      // Scroll to the end
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    // 使用 animateTo 确保滚动到最下面
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 20, // 增加一个小的偏移量
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

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
