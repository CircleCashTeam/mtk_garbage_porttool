import 'package:fluent_ui/fluent_ui.dart';
import 'package:mtk_garbage_porttool/pages/info_card.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PageInfo extends StatelessWidget {
  Future<Map<String, String>> getPackageInfos() async {
    var pinfo = await PackageInfo.fromPlatform();

    return {
      "应用名称": pinfo.appName,
      "版本": pinfo.version,
      "BuildNumber": pinfo.buildNumber,
      //"Signature": pinfo.buildSignature,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/CircleCashTeamLogo.png",
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "CircleCashTeam",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                HyperlinkButton(
                  child: const Row(
                    children: [
                      Icon(FluentIcons.git_graph),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Visit us on Github"),
                    ],
                  ),
                  onPressed: () {
                    launchUrlString("https://github.com/CircleCashTeam");
                  },
                )
              ],
            ),
          ),
          InfoCard(
            title: "关于",
            subTitle: "关于此程序",
            child: Column(
              children: [
                const ListTile(
                  title: Text("程序UI"),
                  trailing: Text("affggh"),
                ),
                const ListTile(
                  title: Text("程序逻辑"),
                  trailing: Text("可乐 Kocleo"),
                ),
                FutureBuilder(
                    future: getPackageInfos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ProgressRing();
                      } else {
                        return Column(
                          children: List.generate(snapshot.data!.keys.length,
                              (index) {
                            return ListTile(
                              title: Text(snapshot.data!.keys.elementAt(index)),
                              trailing:
                                  Text(snapshot.data!.values.elementAt(index)),
                            );
                          }),
                        );
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
