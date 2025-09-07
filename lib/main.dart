import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/theme.dart';
import 'package:taskati/feature/splash/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.deleteFromDisk();
  await LocalHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalHelper.userbox.listenable(),
      builder: (context, box, child) {
        bool isDark = LocalHelper.getData(LocalHelper.KDark) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppThheme.lightTheme,
          darkTheme: AppThheme.darkTheme,

          home: SplashScreen(),
        );
      },
    );
  }
}
