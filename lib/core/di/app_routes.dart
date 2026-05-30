import 'package:get/get.dart';
import '../../view/screens/onboarding_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/note_detail_screen.dart';
import '../constants/app_constants.dart';
import '../di/app_binding.dart';

class AppRoutes {
  AppRoutes._();

  static final pages = [
    GetPage(
      name: AppConstants.onboardingRoute,
      page: () => const OnboardingScreen(),
      binding: AppBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppConstants.homeRoute,
      page: () => const HomeScreen(),
      binding: AppBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppConstants.noteDetailRoute,
      page: () => const NoteDetailScreen(),
      binding: AppBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
