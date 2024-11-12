import 'package:equatable/equatable.dart';

class NoteState extends Equatable {
  final List<Map<String, dynamic>> notes;
  final bool isLoading;

  const NoteState({this.notes = const [], this.isLoading = false});

  NoteState copyWith({List<Map<String, dynamic>>? notes, bool? isLoading}) {
    return NoteState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [notes, isLoading];
}
