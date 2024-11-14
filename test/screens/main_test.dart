import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:cbs_notes_crud/helpers/db_helper.dart';
import 'package:cbs_notes_crud/main.dart';
import 'package:cbs_notes_crud/screens/note_edit_screen.dart';
import 'package:cbs_notes_crud/screens/note_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'main_test.mocks.dart';

@GenerateMocks([DBHelper])
void main() {
  late MockDBHelper mockDBHelper;
  late NoteBloc noteBloc;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    mockDBHelper = MockDBHelper();
    noteBloc = NoteBloc(mockDBHelper);
  });

  tearDown(() {
    noteBloc.close();
  });

  testWidgets('Test MyApp widget and initial route',
      (WidgetTester tester) async {
    when(mockDBHelper.readAllNotes()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => noteBloc..add(LoadNotes()),
        child: const MyApp(),
      ),
    );

    expect(find.byType(NoteListScreen), findsOneWidget);
  });

  testWidgets('Navigate to NoteEditScreen', (WidgetTester tester) async {
    when(mockDBHelper.readAllNotes()).thenAnswer((_) async => []);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => noteBloc..add(LoadNotes()),
        child: const MyApp(),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(NoteEditScreen), findsOneWidget);
  });
}
