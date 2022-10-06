part of 'notes_cubit.dart';

class NotesState extends Equatable {
  final int autoId;
  final List<Note> notesList;

  const NotesState({required this.notesList, required this.autoId});

  @override
  List<Object?> get props => [notesList];

  NotesState copyWith({
    int? autoId,
    List<Note>? notesList,
  }) {
    return NotesState(
      autoId: autoId ?? this.autoId,
      notesList: notesList ?? this.notesList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autoId': autoId,
      'notesList': notesList.map((note) => note.toMap()).toList(),
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      notesList: List<Note>.from(map['notesList'].map((x) => Note.fromMap(x))),
      autoId: map['autoId'] as int,
    );
  }
}
