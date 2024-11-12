import 'package:bloc/bloc.dart';
import 'package:cbs_notes_crud/helpers/db_helper.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final DBHelper dbHelper;

  NoteBloc(this.dbHelper) : super(const NoteState()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(state.copyWith(isLoading: true));
    final notes = await dbHelper.readAllNotes();
    emit(state.copyWith(notes: notes, isLoading: false));
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    await dbHelper.create(event.note);
    add(LoadNotes());
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    await dbHelper.update(event.note);
    add(LoadNotes());
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    await dbHelper.delete(event.id);
    add(LoadNotes());
  }
}
