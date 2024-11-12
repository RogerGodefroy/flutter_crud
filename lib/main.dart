import 'package:cbs_notes_crud/providers/note_provider.dart';
import 'package:cbs_notes_crud/screens/note_edit_screen.dart';
import 'package:cbs_notes_crud/screens/note_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CBSNoteApp());
}

class CBSNoteApp extends StatelessWidget {
  const CBSNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        title: 'CBS Note CRUD',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: const NoteListScreen(),
        routes: {
          NoteEditScreen.routeName: (context) => const NoteEditScreen(),
        },
      ),
    );
  }
}
