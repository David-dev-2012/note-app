import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../model/note_model.dart';
import '../model/notes_repository.dart';
import '../core/constants/app_constants.dart';
import '../core/constants/app_colors.dart';

class NotesController extends GetxController {
  final NotesRepository _repository;

  NotesController(this._repository);

  // ── Observables ──────────────────────────────────────────
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxList<NoteModel> filteredNotes = <NoteModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  // ── Note Form Fields ─────────────────────────────────────
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final RxInt selectedColorIndex = 0.obs;

  NoteModel? _editingNote;

  // ── Getters ──────────────────────────────────────────────
  bool get hasNotes => notes.isNotEmpty;
  bool get isEditing => _editingNote != null;

  Color get selectedNoteColor =>
      AppColors.noteColors[selectedColorIndex.value % AppColors.noteColors.length];

  // ── Lifecycle ────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    loadNotes();
    debounce(
      searchQuery,
      (_) => _performSearch(),
      time: const Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }

  // ── Load ─────────────────────────────────────────────────
  void loadNotes() {
    isLoading.value = true;
    notes.assignAll(_repository.getAllNotes());
    filteredNotes.assignAll(notes);
    isLoading.value = false;
  }

  // ── Prepare New Note ─────────────────────────────────────
  void prepareNewNote() {
    _editingNote = null;
    titleController.clear();
    bodyController.clear();
    selectedColorIndex.value = notes.length % AppColors.noteColors.length;
  }

  // ── Prepare Edit Note ────────────────────────────────────
  void prepareEditNote(NoteModel note) {
    _editingNote = note;
    titleController.text = note.title;
    bodyController.text = note.body;
    selectedColorIndex.value = note.colorIndex;
  }

  // ── Save Note ────────────────────────────────────────────
  Future<bool> saveNote() async {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      return false; // triggers validation alert
    }

    final now = DateTime.now();

    if (_editingNote != null) {
      // Update existing
      final updated = _editingNote!.copyWith(
        title: title,
        body: body,
        updatedAt: now,
        colorIndex: selectedColorIndex.value,
      );
      await _repository.updateNote(updated);
    } else {
      // Create new
      final note = NoteModel(
        id: const Uuid().v4(),
        title: title,
        body: body,
        createdAt: now,
        updatedAt: now,
        colorIndex: selectedColorIndex.value,
      );
      await _repository.addNote(note);
    }

    loadNotes();
    Get.back();
    Get.snackbar(
      '',
      AppStrings.noteSaved,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
    return true;
  }

  // ── Delete Note ──────────────────────────────────────────
  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
    loadNotes();
    Get.back();
    Get.snackbar(
      '',
      AppStrings.noteDeleted,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  // ── Search ───────────────────────────────────────────────
  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void _performSearch() {
    if (searchQuery.value.isEmpty) {
      filteredNotes.assignAll(notes);
    } else {
      filteredNotes.assignAll(_repository.searchNotes(searchQuery.value));
    }
  }

  void toggleSearch() {
    isSearching.toggle();
    if (!isSearching.value) {
      searchQuery.value = '';
      filteredNotes.assignAll(notes);
    }
  }

  // ── Color Picker ─────────────────────────────────────────
  void selectColor(int index) {
    selectedColorIndex.value = index;
  }

  // ── Delete Current Note (used from detail screen) ─────
  Future<void> deleteCurrentNote() async {
    if (_editingNote != null) {
      await deleteNote(_editingNote!.id);
    } else {
      Get.back();
    }
  }

  // ── Pin / Unpin ──────────────────────────────────────────
  Future<void> togglePin(NoteModel note) async {
    final updated = note.copyWith(isPinned: !note.isPinned);
    await _repository.updateNote(updated);
    loadNotes();
  }

  Future<void> pinNote(NoteModel note) async {
    if (!note.isPinned) {
      await togglePin(note);
    }
  }

  Future<void> unpinNote(NoteModel note) async {
    if (note.isPinned) {
      await togglePin(note);
    }
  }

  NoteModel? get editingNote => _editingNote;
}