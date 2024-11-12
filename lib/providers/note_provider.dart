import 'package:cbs_notes_crud/helpers/db_helper.dart';
import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes = await DBHelper.instance.readAllNotes();
    notifyListeners();
  }

  Future<void> addNote(Map<String, dynamic> note) async {
    await DBHelper.instance.create(note);
    await fetchNotes();
  }

  Future<void> updateNote(Map<String, dynamic> note) async {
    await DBHelper.instance.update(note);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await DBHelper.instance.delete(id);
    await fetchNotes();
  }
}
