import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

const double _kDefaultTitleBarHeight = 36;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: MyNav(),
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      themeMode: themeMode,
    );
  }

  void toggleTheme() {
    setState(() {
      themeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    });
  }
}

class MyNav extends StatefulWidget {
  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          height: _kDefaultTitleBarHeight,
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WindowCaptionButton.minimize(
                brightness: FluentTheme.of(context).brightness,
                onPressed: () => windowManager.minimize(),
              ),
              WindowCaptionButton.close(
                brightness: FluentTheme.of(context).brightness,
                onPressed: () => windowManager.close(),
              ),
            ],
          ),
          title: SizedBox.expand(
              child: DragToMoveArea(
            child: Container(
                alignment: Alignment.centerLeft, child: const Text("联发科垃圾移植工具")),
          ))),
      pane: NavigationPane(
          size: const NavigationPaneSize(openMaxWidth: 120),
          selected: pageIndex,
          onItemPressed: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("主页"),
                body: const Center(child: Text("Hello"))),
            PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("主页2"),
                body: const Center(child: Text("Hello2")))
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.info),
                body: const Center(child: Text("About")),
                title: const Text("关于")),
            PaneItem(
                icon: const Icon(FluentIcons.settings),
                body: const Center(child: Text("Settings")),
                title: const Text("设置"))
          ]),
    );
  }
}
