import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final Map<String, dynamic> note;

  const AddNote(this.note);

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NoteEvent {
  final Map<String, dynamic> note;

  const UpdateNote(this.note);

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}
