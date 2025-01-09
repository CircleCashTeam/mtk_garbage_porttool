import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import './info_card.dart';

const message = """\
这个工具是完全免费的
你要是花钱买的
那你就是个大傻逼
""";

class PageHome extends StatelessWidget {
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
              child: const Text(message,
                style: TextStyle(
                    color: Colors.warningPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
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
                  title: const TextBox(),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(width: 160 ,child: Button(child: const Text("选择System镜像"), onPressed: () {})),
                  ),
                ),
                ListTile(
                  title: const TextBox(),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(width: 160 ,child: Button(child: const Text("选择Boot镜像"), onPressed: () {})),
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
