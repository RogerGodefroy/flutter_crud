import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteEvent', () {
    test('LoadNotes supports value comparisons', () {
      expect(
        LoadNotes(),
        LoadNotes(),
      );
    });

    test('AddNote supports value comparisons', () {
      const note = {'id': 1, 'title': 'Test', 'content': 'Test content'};
      expect(
        const AddNote(note),
        const AddNote(note),
      );
    });

    test('UpdateNote supports value comparisons', () {
      const note = {
        'id': 1,
        'title': 'Updated Test',
        'content': 'Updated content'
      };
      expect(
        const UpdateNote(note),
        const UpdateNote(note),
      );
    });

    test('DeleteNote supports value comparisons', () {
      expect(
        const DeleteNote(1),
        const DeleteNote(1),
      );
    });

    test('AddNote props are correct', () {
      const note = {'id': 1, 'title': 'Test', 'content': 'Test content'};
      expect(
        const AddNote(note).props,
        [note],
      );
    });

    test('UpdateNote props are correct', () {
      const note = {
        'id': 1,
        'title': 'Updated Test',
        'content': 'Updated content'
      };
      expect(
        const UpdateNote(note).props,
        [note],
      );
    });

    test('DeleteNote props are correct', () {
      expect(
        const DeleteNote(1).props,
        [1],
      );
    });
  });
}
