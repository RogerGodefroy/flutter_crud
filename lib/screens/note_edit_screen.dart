import 'package:cbs_notes_crud/bloc/note_bloc.dart';
import 'package:cbs_notes_crud/bloc/note_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteEditScreen extends StatelessWidget {
  static const routeName = '/edit-note';

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  NoteEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final note =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (note != null) {
      _formData['id'] = note['id'];
      _formData['title'] = note['title'];
      _formData['content'] = note['content'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _formData['title'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['content'],
                decoration: const InputDecoration(labelText: 'Content'),
                onSaved: (value) {
                  _formData['content'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_formData['id'] == null) {
                      BlocProvider.of<NoteBloc>(context).add(AddNote({
                        'title': _formData['title'],
                        'content': _formData['content'],
                      }));
                    } else {
                      BlocProvider.of<NoteBloc>(context).add(UpdateNote({
                        'id': _formData['id'],
                        'title': _formData['title'],
                        'content': _formData['content'],
                      }));
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
