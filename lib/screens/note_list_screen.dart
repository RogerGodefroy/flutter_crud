import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:cbs_notes_crud/bloc/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_edit_screen.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (ctx, index) {
                final note = state.notes[index];
                return Column(
                  children: [
                    Dismissible(
                      key: Key(note['id'].toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        BlocProvider.of<NoteBloc>(context)
                            .add(DeleteNote(note['id']));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('${note['title']} verwijderd')),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(
                          note['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            NoteEditScreen.routeName,
                            arguments: note,
                          );
                        },
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NoteEditScreen.routeName);
        },
      ),
    );
  }
}
