import 'package:cbs_notes_crud/bloc/note_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteState', () {
    test('supports value comparisons', () {
      expect(
        const NoteState(),
        const NoteState(),
      );
    });

    test('props are correct', () {
      const state = NoteState(
        notes: [
          {'id': 1, 'title': 'Test', 'content': 'Test content'}
        ],
        isLoading: true,
      );
      expect(state.props, [
        [
          {'id': 1, 'title': 'Test', 'content': 'Test content'}
        ],
        true,
      ]);
    });

    test('copyWith returns the same object if no parameters are provided', () {
      const state = NoteState(
        notes: [
          {'id': 1, 'title': 'Test', 'content': 'Test content'}
        ],
        isLoading: true,
      );
      expect(state.copyWith(), state);
    });

    test('copyWith retains old value for every parameter if null is provided',
        () {
      const state = NoteState(
        notes: [
          {'id': 1, 'title': 'Test', 'content': 'Test content'}
        ],
        isLoading: true,
      );
      expect(
        state.copyWith(notes: null, isLoading: null),
        state,
      );
    });

    test('copyWith replaces every non-null parameter', () {
      const state = NoteState(
        notes: [
          {'id': 1, 'title': 'Test', 'content': 'Test content'}
        ],
        isLoading: true,
      );
      const newState = NoteState(
        notes: [
          {'id': 2, 'title': 'New Test', 'content': 'New content'}
        ],
        isLoading: false,
      );
      expect(
        state.copyWith(
          notes: [
            {'id': 2, 'title': 'New Test', 'content': 'New content'}
          ],
          isLoading: false,
        ),
        newState,
      );
    });
  });
}
