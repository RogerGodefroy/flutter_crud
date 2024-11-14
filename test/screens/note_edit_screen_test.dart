import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/screens/note_edit_screen.dart';
import 'dart:async';

import 'note_bloc.mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  late MockNoteBloc mockNoteBloc;

  setUp(() {
    mockNoteBloc = MockNoteBloc();
    when(mockNoteBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetUnderTest({Map<String, dynamic>? arguments}) {
    return MaterialApp(
      home: BlocProvider<NoteBloc>(
        create: (context) => mockNoteBloc,
        child: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => NoteEditScreen(),
              settings: RouteSettings(arguments: arguments),
            );
          },
        ),
      ),
    );
  }

  testWidgets('should display form fields', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('should display validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Please enter a title'), findsOneWidget);
    expect(find.text('Please enter content'), findsOneWidget);
  });

  testWidgets('should add a new note', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).at(0), 'New Note Title');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'New Note Content');

    await tester.tap(find.text('Save'));
    await tester.pump();

    verify(mockNoteBloc.add(const AddNote({
      'title': 'New Note Title',
      'content': 'New Note Content',
    }))).called(1);
  });

  testWidgets('should update an existing note', (WidgetTester tester) async {
    final note = {
      'id': 1,
      'title': 'Existing Note Title',
      'content': 'Existing Note Content',
    };

    await tester.pumpWidget(createWidgetUnderTest(arguments: note));

    await tester.enterText(
        find.byType(TextFormField).at(0), 'Updated Note Title');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Updated Note Content');

    await tester.tap(find.text('Save'));
    await tester.pump();

    verify(mockNoteBloc.add(const UpdateNote({
      'id': 1,
      'title': 'Updated Note Title',
      'content': 'Updated Note Content',
    }))).called(1);
  });
}
