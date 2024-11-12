import 'package:cbs_notes_crud/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteEditScreen extends StatefulWidget {
  static const routeName = '/edit-note';

  const NoteEditScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': '',
    'content': '',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final note =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (note != null && _formData['id'] == null) {
      setState(() {
        _formData['id'] = note['id'];
        _formData['title'] = note['title'];
        _formData['content'] = note['content'];
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

      if (_formData['id'] == null) {
        noteProvider.addNote({
          'title': _formData['title'],
          'content': _formData['content'],
        });
      } else {
        noteProvider.updateNote({
          'id': _formData['id'],
          'title': _formData['title'],
          'content': _formData['content'],
        });
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _formData['id'] == null ? 'Notitie toevoegen' : 'Wijzigen notitie'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['title'],
                decoration: const InputDecoration(labelText: 'Titel'),
                onSaved: (value) {
                  _formData['title'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voeg een titel toe';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['content'],
                decoration: const InputDecoration(labelText: 'Notitie'),
                onSaved: (value) {
                  _formData['content'] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voeg inhoud van de notitie toe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Opslaan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
