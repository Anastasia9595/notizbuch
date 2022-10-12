part of 'notes_cubit.dart';

class NotesState extends Equatable {
  final int autoId;
  final Note? selectedNote;
  final bool selectNote;

  final List<Note> notesList;

  const NotesState(
      {required this.notesList, required this.autoId, required this.selectedNote, required this.selectNote});

  @override
  List<Object?> get props => [notesList, autoId, selectedNote, selectedNote];

  NotesState copyWith({
    int? autoId,
    List<Note>? notesList,
    int? noteId,
    Note? selectedNote,
    bool? select,
  }) {
    return NotesState(
      autoId: autoId ?? this.autoId,
      notesList: notesList ?? this.notesList,
      selectNote: select ?? selectNote,
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
      'selectNote': selectNote,
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      autoId: map['autoId'] as int,
      notesList: List<Note>.from(map['notesList']?.map((x) => Note.fromMap(x))),
      selectedNote: map['selectedNote'] != null ? Note.fromMap(map['selectedNote']) : null,
      selectNote: map['selectNote'],
    );
  }
}
