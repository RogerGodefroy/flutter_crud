import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:cbs_notes_crud/bloc/note_state.dart';
import 'package:cbs_notes_crud/screens/note_edit_screen.dart';
import 'package:cbs_notes_crud/screens/note_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

class MockNoteBloc extends MockBloc<NoteEvent, NoteState> implements NoteBloc {}

void main() {
  late MockNoteBloc mockNoteBloc;

  setUp(() {
    mockNoteBloc = MockNoteBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<NoteBloc>(
        create: (_) => mockNoteBloc,
        child: const NoteListScreen(),
      ),
      routes: {
        NoteEditScreen.routeName: (ctx) => NoteEditScreen(),
      },
    );
  }

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockNoteBloc.state)
        .thenAnswer((_) => const NoteState(isLoading: true, notes: []));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays notes when state is not loading', (tester) async {
    final notes = [
      {'id': 1, 'title': 'Test Note 1'},
      {'id': 2, 'title': 'Test Note 2'},
    ];
    when(() => mockNoteBloc.state)
        .thenAnswer((_) => NoteState(isLoading: false, notes: notes));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ListTile), findsNWidgets(notes.length));
    expect(find.text('Test Note 1'), findsOneWidget);
    expect(find.text('Test Note 2'), findsOneWidget);
  });

  testWidgets('navigates to NoteEditScreen when a note is tapped',
      (tester) async {
    final notes = [
      {'id': 1, 'title': 'Test Note 1'},
    ];
    when(() => mockNoteBloc.state)
        .thenAnswer((_) => NoteState(isLoading: false, notes: notes));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Test Note 1'));
    await tester.pumpAndSettle();

    expect(find.byType(NoteEditScreen), findsOneWidget);
  });

  testWidgets('shows snackbar when note is dismissed', (tester) async {
    final notes = [
      {'id': 1, 'title': 'Test Note 1'},
    ];
    when(() => mockNoteBloc.state)
        .thenAnswer((_) => NoteState(isLoading: false, notes: notes));
    when(() => mockNoteBloc.add(const DeleteNote(1))).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.text('Test Note 1 verwijderd'), findsOneWidget);
  });

  testWidgets(
      'navigates to NoteEditScreen when floating action button is pressed',
      (tester) async {
    when(() => mockNoteBloc.state)
        .thenAnswer((_) => const NoteState(isLoading: false, notes: []));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(NoteEditScreen), findsOneWidget);
  });
}
