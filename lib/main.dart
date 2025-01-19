import 'dart:developer';
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:mtk_garbage_porttool/pages/pages.dart';

const double _kDefaultTitleBarHeight = 36;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }
  windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(800, 600),
    size: Size(800, 600),
    center: true,
    //backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

Future<int> getWindowsBuildNumber() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;

  // 获取系统版本
  int buildNumber = windowsInfo.buildNumber;

  return buildNumber;
}

Future<WindowEffect> getCorrectWindowEffect() async {
  var effect = WindowEffect.solid;
  if (Platform.isWindows) {
    final buildNumber = await getWindowsBuildNumber();
    log("Get build Number: $buildNumber");
    if (buildNumber > 22523) {
      effect = WindowEffect.tabbed;
    } else if (buildNumber > 22000) {
      effect = WindowEffect.mica;
    } else if (buildNumber > 10240) {
      effect = WindowEffect.acrylic;
    }
    //if (buildNumber > 10240) {
    //  effect = WindowEffect.acrylic;
    //}
  }
  log("Set window effect: ${effect.name}");
  return effect;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //var themeMode = ThemeMode.system;
  // Force dark theme
  var themeMode = ThemeMode.dark;

  void setWindowEffect() async {
    Window.setEffect(
      effect: await getCorrectWindowEffect(),
      color: Colors.transparent,
      //color: Platform.isWindows ? const Color(0xCC222222) : Colors.transparent,
      dark: true,
    );
  }

  @override
  void initState() {
    super.initState();
    setWindowEffect();
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: const MyNav(),
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          navigationPaneTheme: NavigationPaneThemeData(
              backgroundColor: Platform.isWindows ? Colors.transparent : null)),
      darkTheme: FluentThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          navigationPaneTheme: NavigationPaneThemeData(
              backgroundColor: Platform.isWindows ? Colors.transparent : null)),
      color: Colors.transparent,
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
          backgroundColor: Colors.transparent,
          leading: Image.asset(
            "assets/CircleCashTeamLogo.png",
            width: 24,
            height: 24,
          ),
          automaticallyImplyLeading: false,
          height: _kDefaultTitleBarHeight,
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Tooltip(
              //  message: "切换亮暗主题",
              //  child: IconButton(
              //      icon: Icon(
              //          FluentTheme.of(context).brightness == Brightness.dark
              //              ? FluentIcons.lower_brightness
              //              : FluentIcons.brightness),
              //      onPressed: () {
              //        context
              //            .findAncestorStateOfType<_MyAppState>()
              //            ?.toggleTheme(context);
              //      }),
              //),
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
              body: Container(
                color: FluentTheme.of(context).cardColor,
                child: PageHome()),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.app_icon_default),
              title: const Text("移植"),
              body: Container(
                color: FluentTheme.of(context).cardColor,
                child: PagePort()),
            ),
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.info),
                body: Container(
                  color: FluentTheme.of(context).cardColor,
                  child: PageInfo()),
                title: const Text("关于")),
            //PaneItem(
            //    icon: const Icon(FluentIcons.settings),
            //    body: const Center(child: Text("Settings")),
            //    title: const Text("设置"))
          ]),
    );
  }
}
