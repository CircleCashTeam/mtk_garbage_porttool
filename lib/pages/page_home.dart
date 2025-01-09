import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mtk_garbage_porttool/common.dart';
import 'package:mtk_garbage_porttool/pages/info_card.dart';

const message = """\
这个工具是完全免费的
你要是花钱买的
那你就是个大傻逼
""";

class PageHome extends StatelessWidget {
  PageHome({super.key}) {
    systemController.text = pathController.getSystemImagePath();
    bootController.text = pathController.getBootImagePath();
  }

  final pathController = Get.put(BaseItemController());

  final systemController = TextEditingController();
  final bootController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          InfoCard(
            title: "说在前头",
            subTitle: "仔细看",
            child: Container(
              padding: const EdgeInsets.all(40),
              child: const Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.warningPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InfoCard(
            title: "选择你的系统system和boot镜像",
            child: Column(
              children: [
                ListTile(
                  title: TextBox(
                    controller: systemController,
                    readOnly: true,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                        width: 160,
                        child: Button(
                            child: const Text("选择System镜像"),
                            onPressed: () async {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                dialogTitle: "选择system镜像",
                                allowMultiple: false,
                              );
                              if (result != null) {
                                systemController.text =
                                    result.files.first.path!;
                                pathController.setSystemImagePath(
                                    result.files.first.path!);
                              }
                            })),
                  ),
                ),
                ListTile(
                  title: TextBox(
                    controller: bootController,
                    readOnly: true,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                        width: 160,
                        child: Button(
                            child: const Text("选择Boot镜像"),
                            onPressed: () async {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                dialogTitle: "选择boot镜像",
                                allowMultiple: false,
                              );
                              if (result != null) {
                                bootController.text = result.files.first.path!;
                                pathController
                                    .setBootImagePath(result.files.first.path!);
                              }
                            })),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
