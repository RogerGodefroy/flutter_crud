import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:cbs_notes_crud/helpers/db_helper.dart';
import 'package:cbs_notes_crud/screens/note_edit_screen.dart';
import 'package:cbs_notes_crud/screens/note_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DBHelper.instance;

    return BlocProvider(
      create: (context) => NoteBloc(dbHelper)..add(LoadNotes()),
      child: MaterialApp(
        title: 'Note App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NoteListScreen(),
        routes: {
          NoteEditScreen.routeName: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
