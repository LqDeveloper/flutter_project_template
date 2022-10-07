import 'package:flutter/material.dart';
import 'package:flutter_project/configs/theme_manager.dart';

class AppInit {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();
    ThemeManager.initTheme();
  }
}
