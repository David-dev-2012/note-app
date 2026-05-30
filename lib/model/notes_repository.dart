import 'package:hive_flutter/hive_flutter.dart';
import '../model/note_model.dart';
import '../core/constants/app_constants.dart';

class NotesRepository {
  Box<NoteModel> get _box => Hive.box<NoteModel>(AppConstants.notesBox);

  // ── Create ───────────────────────────────────────────────
  Future<void> addNote(NoteModel note) async {
    await _box.put(note.id, note);
  }

  // ── Read ─────────────────────────────────────────────────
  List<NoteModel> getAllNotes() {
    final notes = _box.values.toList();
    notes.sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });
    return notes;
  }

  NoteModel? getNoteById(String id) {
    return _box.get(id);
  }

  // ── Update ───────────────────────────────────────────────
  Future<void> updateNote(NoteModel note) async {
    await _box.put(note.id, note);
  }

  // ── Delete ───────────────────────────────────────────────
  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }

  // ── Search ───────────────────────────────────────────────
  List<NoteModel> searchNotes(String query) {
    if (query.isEmpty) return getAllNotes();
    final lower = query.toLowerCase();
    return _box.values
        .where(
          (note) =>
              note.title.toLowerCase().contains(lower) ||
              note.body.toLowerCase().contains(lower),
        )
        .toList()
      ..sort((a, b) {
        if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });
  }

  // ── Count ────────────────────────────────────────────────
  int get notesCount => _box.length;

  bool get isEmpty => _box.isEmpty;

  // ── Stream for reactive updates ──────────────────────────
  Stream<BoxEvent> watchNotes() => _box.watch();
}
