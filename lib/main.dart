import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'core/di/app_binding.dart';
import 'core/di/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'model/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── System UI ──────────────────────────────────────────
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // ── Hive Init ──────────────────────────────────────────
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());

  // Open Hive boxes
  await Hive.openBox<NoteModel>(AppConstants.notesBox);
  await Hive.openBox(AppConstants.settingsBox);

  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design frame matching Figma: 375 x 812
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialBinding: AppBinding(),
          initialRoute: _getInitialRoute(),
          getPages: AppRoutes.pages,
        );
      },
    );
  }

  String _getInitialRoute() {
    final box = Hive.box(AppConstants.settingsBox);
    final isFirstOpen = box.get(AppConstants.isFirstOpen, defaultValue: true);
    return isFirstOpen
        ? AppConstants.onboardingRoute
        : AppConstants.homeRoute;
  }
}
