import 'package:get/get.dart';
import '../../model/notes_repository.dart';
import '../../controller/notes_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Repository - singleton
    Get.lazyPut<NotesRepository>(
      () => NotesRepository(),
      fenix: true,
    );

    // Controller - singleton
    Get.lazyPut<NotesController>(
      () => NotesController(Get.find<NotesRepository>()),
      fenix: true,
    );
  }
}
