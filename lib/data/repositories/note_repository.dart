import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/note_model.dart';

class NoteRepository {
  final String baseUrl;

  NoteRepository(this.baseUrl);

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((note) => Note.fromJson(note)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<Note> createNote(Note note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(note.toJson()),
    );
    if (response.statusCode == 201) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create note');
    }
  }

  Future<Note> updateNote(Note note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notes/${note.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(note.toJson()),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update note');
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete note');
    }
  }
}
