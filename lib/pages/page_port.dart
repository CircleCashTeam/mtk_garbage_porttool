import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mtk_garbage_porttool/common.dart';

const portMethods = [
  'MTK Common Kernel and Options',
  'MT6735/37(m) Kernel 3.18.19',
  'MT6572/82/92 Kernel 3.4.67',
];

class PortMethodController extends GetxController {
  var portMethod = portMethods[0].obs;
  var outputImg = false.obs;
}

class PagePort extends StatelessWidget {
  final logController = Get.find<LogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PagePortLeft(),
            const SizedBox(
              width: 10,
            ),
            PagePortRight(),
          ],
        ));
  }
}

class PagePortLeft extends StatelessWidget {
  final portMethodController = Get.put(PortMethodController());
  final logController = Get.find<LogController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: ListTile(
              title: const Text("选择一个移植方案"),
              subtitle: Obx(() => Text(portMethodController.portMethod.value)),
              leading: const Icon(FluentIcons.cake),
              trailing: DropDownButton(
                  title: const Text("选择方案"),
                  items: portMethods.map((value) {
                    return MenuFlyoutItem(
                        text: Text(value),
                        onPressed: () {
                          logController.addlog("选择移植方案: $value");
                          portMethodController.portMethod.value = value;
                        });
                  }).toList()),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Card(
              child: TreeView(
                  selectionMode: TreeViewSelectionMode.multiple,
                  shrinkWrap: true,
                  items: List.generate(200, (value) {
                    return TreeViewItem(
                        content: Text("item $value"), value: value);
                  })),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Button(
                      child: const Text("选择ROM"),
                      onPressed: () {
                        logController.addlog("选择要移植的卡刷包");
                      })),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: FilledButton(
                      child: const Text("开始移植"),
                      onPressed: () {
                        logController.addlog("开始移植");
                      })),
            ],
          ),
          Expanded(
            flex: 0,
            child: ListTile(
              leading: const Icon(FluentIcons.configuration_solid),
              title: const Text("输出为IMG"),
              subtitle: const Text("输出img镜像文件"),
              trailing: Obx(
                () => Checkbox(
                    checked: portMethodController.outputImg.value,
                    onChanged: (value) {
                      portMethodController.outputImg.value = value ?? false;
                      logController.addlog(
                          "当前输出镜像方案为: ${value ?? false ? "镜像" : "卡刷包"}");
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PagePortRight extends StatefulWidget {
  @override
  State<PagePortRight> createState() => _PagePortRightState();
}

class _PagePortRightState extends State<PagePortRight> {
  final logController = Get.find<LogController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("日志输出"),
              Button(
                  child: const Text("清除"),
                  onPressed: () {
                    logController.clear();
                    logController.controller.clear();
                  })
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TextBox(
              minLines: null,
              maxLines: null,
              readOnly: true,
              controller: logController.controller,
              scrollController: logController.scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
