import 'package:cbs_notes_crud/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_edit_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notities'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: Provider.of<NoteProvider>(context, listen: false).fetchNotes(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const NoteList();
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

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (ctx, noteProvider, _) {
        return ListView.builder(
          itemCount: noteProvider.notes.length,
          itemBuilder: (ctx, index) {
            final note = noteProvider.notes[index];
            return Column(
              children: [
                Dismissible(
                  key: Key(note['id'].toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    noteProvider.deleteNote(note['id']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${note['title']} verwijderd')),
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
      },
    );
  }
}
