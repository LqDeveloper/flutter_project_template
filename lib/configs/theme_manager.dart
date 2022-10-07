import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/src/animations/scale_animation.dart';

class ThemeManager {
  //设置不允许字体放大
  static const double textScaleFactor = 1.0;

  //设置App支持的屏幕方向
  static const List<DeviceOrientation> supportOrientations = [
    DeviceOrientation.portraitUp
  ];

  //[AppBar.title] 和 [AlertDialog.title]）等字体样式
  static const TextStyle titleLarge =
      TextStyle(fontSize: 30.0, color: Colors.red);

  //用于列表中的主要文本（例如，[ListTile.title]）。
  static const TextStyle titleMedium =
      TextStyle(fontSize: 25.0, color: Colors.blue);

  // [Material]的默认文本样式。
  static const TextStyle defaultStyle =
      TextStyle(fontSize: 25.0, color: Colors.blue);

  // 用于 [ElevatedButton]、[TextButton] 和 [OutlinedButton] 上的文本。
  static const TextStyle buttonStyle =
      TextStyle(fontSize: 25.0, color: Colors.blue);

  //用于 [showDatePicker] 显示的对话框中的日期。
  static const TextStyle pickerStyle =
      TextStyle(fontSize: 25.0, color: Colors.blue);

  //字体
  static const String fontFamily = '';

  //AppBar标题颜色
  static const Color appBarTitleColor = Colors.green;

  //AppBar背景颜色
  static const Color appBarBgColor = Colors.green;

  //Scaffold背景颜色
  static const Color scaffoldBgColor = Colors.amberAccent;

  static const Color dialogBgColor = Colors.white;

  //可滚动组件的背景颜色
  static const Color scrollBgColor = Colors.cyan;

  //页面跳转样式
  static const PageTransitionsTheme pageTransitionsTheme =
      PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
  });

  //ThemeData
  static final ThemeData themeData = ThemeData(
      brightness: Brightness.light,
      pageTransitionsTheme: pageTransitionsTheme,
      fontFamily: fontFamily,
      textTheme: const TextTheme(
        displayMedium: pickerStyle,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        bodyMedium: defaultStyle,
        labelLarge: buttonStyle,
      ),
      scaffoldBackgroundColor: scaffoldBgColor,
      dialogBackgroundColor: dialogBgColor,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.white,
        background: scrollBgColor,
      ),
      //去掉水波纹
      splashColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          elevation: 1,
          titleTextStyle: titleLarge,
          backgroundColor: appBarBgColor),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.red,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontSize: 20),
          indicatorSize: TabBarIndicatorSize.label),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 1,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          showSelectedLabels: true,
          showUnselectedLabels: true),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ))),
      dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      //以下是可选的
      textButtonTheme: const TextButtonThemeData(),
      elevatedButtonTheme: const ElevatedButtonThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData());

  //配置EasyLoading
  static void _configEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = ScaleAnimation();
  }

  //配置EasyRefresh
  static void _configEasyRefresh() {
    EasyRefresh.defaultHeaderBuilder = () {
      return const ClassicHeader();
    };
    EasyRefresh.defaultFooterBuilder = () {
      return const ClassicFooter();
    };
  }

  //不允许字体跟随系统变化
  static TransitionBuilder setupTransitionBuilder(
      {TransitionBuilder? builder}) {
    return EasyLoading.init(builder: (cxt, child) {
      return MediaQuery(
          data: MediaQuery.of(cxt).copyWith(textScaleFactor: textScaleFactor),
          child: child ?? const SizedBox());
    });
  }

  //runApp 之前调用
  static void _setupDevice() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.green, //状态栏背景颜色
        statusBarIconBrightness: Brightness.light // dark:一般显示黑色   light：一般显示白色
        ));
    //设置屏幕的方向
    SystemChrome.setPreferredOrientations(supportOrientations);
  }

  //在WidgetsFlutterBinding.ensureInitialized();之后调用
  static void initTheme() {
    _configEasyLoading();
    _configEasyRefresh();
    _setupDevice();
  }
}
