import 'package:flutter/material.dart';
import 'package:clean_archi_solid_template/data/models/note_model.dart';
import 'package:clean_archi_solid_template/data/repositories/note_repository.dart';

class NoteProvider with ChangeNotifier {
  final NoteRepository _noteRepository;
  List<Note> _notes = [];

  NoteProvider(this._noteRepository);

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes = await _noteRepository.fetchNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    final newNote = await _noteRepository.createNote(note);
    _notes.add(newNote);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    final updatedNote = await _noteRepository.updateNote(note);
    final index = _notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  Future<void> deleteNote(int id) async {
    await _noteRepository.deleteNote(id);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
