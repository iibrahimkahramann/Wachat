import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedNotes = prefs.getStringList('notes');

    print('Saved Notes: $savedNotes');

    if (savedNotes == null || savedNotes.isEmpty) {
      state = [];
      return;
    }

    state = savedNotes.map((note) {
      final Map<String, String> noteJson =
          Map<String, String>.from(jsonDecode(note));
      return Note.fromJson(noteJson);
    }).toList();
  }

  Future<void> addNote(String title, String text) async {
    final newNote = Note(title: title, text: text);
    state = [...state, newNote];
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
        'notes', state.map((note) => jsonEncode(note.toJson())).toList());

    print('Notes saved: ${state.map((note) => note.toJson())}');
  }

  Future<void> deleteNote(int index) async {
    state = [...state]..removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'notes', state.map((note) => jsonEncode(note.toJson())).toList());
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});
