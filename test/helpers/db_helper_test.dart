import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:cbs_notes_crud/helpers/db_helper.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  late DBHelper dbHelper;

  setUpAll(() async {
    // Initialize sqflite ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Setup the path for the test database
    final directory = await Directory.systemTemp.createTemp();
    final path = join(directory.path, 'test_notes.db');

    // Delete any existing test database
    if (await databaseFactory.databaseExists(path)) {
      await databaseFactory.deleteDatabase(path);
    }

    // Initialize the DBHelper with the test database path
    dbHelper = DBHelper.instance;
    dbHelper.setDbPath(path);
    await dbHelper.database; // Ensure that the test database is initialized
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  test('create note', () async {
    final note = {'title': 'Test Note', 'content': 'This is a test note'};
    final id = await dbHelper.create(note);
    expect(id, isNonZero);
  });

  test('read all notes', () async {
    final notes = await dbHelper.readAllNotes();
    expect(notes, isNotEmpty);
  });

  test('update note', () async {
    final note = {
      'id': 1,
      'title': 'Updated Note',
      'content': 'This is an updated test note'
    };
    final rowsAffected = await dbHelper.update(note);
    expect(rowsAffected, 1);
  });

  test('delete note', () async {
    final rowsDeleted = await dbHelper.delete(1);
    expect(rowsDeleted, 1);
  });
}
