class AppConstants {
  AppConstants._();

  // Hive Box Names
  static const String notesBox = 'notes_box';
  static const String settingsBox = 'settings_box';

  // Settings Keys
  static const String isFirstOpen = 'is_first_open';

  // Routes
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String homeRoute = '/home';
  static const String noteDetailRoute = '/note-detail';
  static const String addNoteRoute = '/add-note';

  // Animations Duration
  static const int animDurationFast = 200;
  static const int animDurationMedium = 350;
  static const int animDurationSlow = 600;

  // Paddings (raw values, apply .w / .h in UI)
  static const double paddingXS = 4;
  static const double paddingS = 8;
  static const double paddingM = 16;
  static const double paddingL = 24;
  static const double paddingXL = 32;
  static const double paddingXXL = 48;

  // Border Radius
  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  static const double radiusXL = 24;
  static const double radiusXXL = 32;
  static const double radiusCircle = 100;
}

class AppStrings {
  AppStrings._();

  static const String appName = 'Notes';
  static const String onboardingTitle = 'All thoughts.\nOne place.';
  static const String onboardingSubtitle =
      'Dive right in and clear that mind of yours by\nwriting your thoughts down';
  static const String getStarted = 'Get Started';
  static const String createFirstNote = 'Create your first note !';
  static const String newNote = 'New Note';
  static const String editNote = 'Edit Note';
  static const String titleHint = 'Title';
  static const String bodyHint = 'Type something...';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String alertTitle = 'Should add title and desc';
  static const String noteDeleted = 'Note deleted successfully';
  static const String noteSaved = 'Note saved successfully';
  static const String noNotes = 'No notes yet';
  static const String searchHint = 'Search notes...';
  static const String back = 'Back';
}
