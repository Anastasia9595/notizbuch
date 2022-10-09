part of 'notes_cubit.dart';

class NotesState extends Equatable {
  final int autoId;
  final Note? selectedNote;

  final List<Note> notesList;

  const NotesState({required this.notesList, required this.autoId, required this.selectedNote});

  @override
  List<Object?> get props => [notesList, autoId, selectedNote];

  NotesState copyWith({
    int? autoId,
    List<Note>? notesList,
    int? noteId,
    Note? selectedNote,
  }) {
    return NotesState(
      autoId: autoId ?? this.autoId,
      notesList: notesList ?? this.notesList,
      selectedNote: notesList != null
          ? notesList.contains(selectedNote)
              ? selectedNote
              : null
          : selectedNote ?? this.selectedNote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'autoId': autoId,
      'notesList': notesList.map((e) => e.toMap()).toList(),
      'selectedNote': selectedNote?.toMap(),
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      autoId: map['autoId'] as int,
      notesList: List<Note>.from(map['notesList']?.map((x) => Note.fromMap(x))),
      selectedNote: map['selectedNote'] != null ? Note.fromMap(map['selectedNote']) : null,
    );
  }
}
