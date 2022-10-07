part of 'notes_cubit.dart';

class NotesState extends Equatable {
  final int autoId;

  final bool isChanged;
  final List<Note> notesList;

  const NotesState({required this.notesList, required this.autoId, required this.isChanged});

  @override
  List<Object?> get props => [notesList, autoId, isChanged];

  NotesState copyWith({
    int? autoId,
    List<Note>? notesList,
    bool? isChanged,
    int? noteId,
  }) {
    return NotesState(
      autoId: autoId ?? this.autoId,
      notesList: notesList ?? this.notesList,
      isChanged: isChanged ?? this.isChanged,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autoId': autoId,
      'notesList': notesList.map((note) => note.toMap()).toList(),
      'isChanged': isChanged,
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      notesList: List<Note>.from(map['notesList'].map((x) => Note.fromMap(x))),
      autoId: map['autoId'] as int,
      isChanged: map['isChanged'] as bool,
    );
  }
}
