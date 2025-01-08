import 'package:fluent_ui/fluent_ui.dart';
import 'package:mtk_garbage_porttool/pages/page_info.dart';
import 'package:window_manager/window_manager.dart';

const double _kDefaultTitleBarHeight = 36;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(800, 600),
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

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: const MyNav(),
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      themeMode: themeMode,
    );
  }

  void toggleTheme(BuildContext context) {
    setState(() {
      themeMode = FluentTheme.of(context).brightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }
}

class MyNav extends StatefulWidget {
  const MyNav({super.key});

  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        leading: Image.asset("assets/CircleCashTeamLogo.png", width: 24,height: 24,),
          automaticallyImplyLeading: false,
          height: _kDefaultTitleBarHeight,
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: "切换亮暗主题",
                child: IconButton(
                    icon: Icon(
                        FluentTheme.of(context).brightness == Brightness.dark
                            ? FluentIcons.lower_brightness
                            : FluentIcons.brightness),
                    onPressed: () {
                      context
                          .findAncestorStateOfType<_MyAppState>()
                          ?.toggleTheme(context);
                    }),
              ),
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
                alignment: Alignment.centerLeft,
                child: const Text("联发科垃圾移植工具")),
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
                icon: const Icon(FluentIcons.app_icon_default),
                title: const Text("移植"),
                body: const Center(child: Text("Hello2")))
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.info),
                body: PageInfo(),
                title: const Text("关于")),
            PaneItem(
                icon: const Icon(FluentIcons.settings),
                body: const Center(child: Text("Settings")),
                title: const Text("设置"))
          ]),
    );
  }
}
