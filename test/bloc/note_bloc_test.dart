import 'package:bloc_test/bloc_test.dart';
import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:cbs_notes_crud/bloc/note_state.dart';
import 'package:cbs_notes_crud/helpers/db_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'note_bloc_test.mocks.dart';

@GenerateMocks([DBHelper])
void main() {
  group('NoteBloc Tests', () {
    late NoteBloc noteBloc;
    late MockDBHelper mockDBHelper;

    setUp(() {
      mockDBHelper = MockDBHelper();
      noteBloc = NoteBloc(mockDBHelper);
    });

    tearDown(() {
      noteBloc.close();
    });

    blocTest<NoteBloc, NoteState>(
      'emits NotesLoaded with notes when LoadNotes is added',
      build: () {
        when(mockDBHelper.readAllNotes()).thenAnswer((_) async => [
              {
                'id': 1,
                'title': 'Test Note',
                'content': 'Content for test note'
              }
            ]);
        return noteBloc;
      },
      act: (bloc) => bloc.add(LoadNotes()),
      expect: () => [
        const NoteState(isLoading: true),
        const NoteState(
          notes: [
            {'id': 1, 'title': 'Test Note', 'content': 'Content for test note'}
          ],
          isLoading: false,
        ),
      ],
    );

    blocTest<NoteBloc, NoteState>(
      'adds a new note and reloads notes when AddNote is added',
      build: () {
        when(mockDBHelper.create(any)).thenAnswer((_) async => 1);
        when(mockDBHelper.readAllNotes()).thenAnswer((_) async => [
              {'id': 1, 'title': 'New Note', 'content': 'New content'}
            ]);
        return noteBloc;
      },
      act: (bloc) => bloc.add(const AddNote({
        'title': 'New Note',
        'content': 'New content',
      })),
      expect: () => [
        const NoteState(isLoading: true),
        const NoteState(
          notes: [
            {'id': 1, 'title': 'New Note', 'content': 'New content'}
          ],
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(mockDBHelper.create(any)).called(1);
        verify(mockDBHelper.readAllNotes()).called(1);
      },
    );

    blocTest<NoteBloc, NoteState>(
      'updates an existing note and reloads notes when UpdateNote is added',
      build: () {
        when(mockDBHelper.update(any)).thenAnswer((_) async => 1);
        when(mockDBHelper.readAllNotes()).thenAnswer((_) async => [
              {'id': 1, 'title': 'Updated Note', 'content': 'Updated content'}
            ]);
        return noteBloc;
      },
      act: (bloc) => bloc.add(const UpdateNote({
        'id': 1,
        'title': 'Updated Note',
        'content': 'Updated content',
      })),
      expect: () => [
        const NoteState(isLoading: true),
        const NoteState(
          notes: [
            {'id': 1, 'title': 'Updated Note', 'content': 'Updated content'}
          ],
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(mockDBHelper.update(any)).called(1);
        verify(mockDBHelper.readAllNotes()).called(1);
      },
    );

    blocTest<NoteBloc, NoteState>(
      'deletes a note and reloads notes when DeleteNote is added',
      build: () {
        when(mockDBHelper.delete(1)).thenAnswer((_) async => 1);
        when(mockDBHelper.readAllNotes()).thenAnswer((_) async => []);
        return noteBloc;
      },
      act: (bloc) => bloc.add(const DeleteNote(1)),
      expect: () => [
        const NoteState(isLoading: true),
        const NoteState(
          notes: [],
          isLoading: false,
        ),
      ],
      verify: (_) {
        verify(mockDBHelper.delete(1)).called(1);
        verify(mockDBHelper.readAllNotes()).called(1);
      },
    );
  });
}
