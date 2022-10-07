part of 'notes_cubit.dart';

class NotesState extends Equatable {
  final int autoId;
  final Note? selectedNote;
  final bool isChanged;
  final List<Note> notesList;

  const NotesState(
      {required this.notesList, required this.autoId, required this.isChanged, required this.selectedNote});

  @override
  List<Object?> get props => [notesList, autoId, isChanged, selectedNote];

  NotesState copyWith({
    int? autoId,
    List<Note>? notesList,
    bool? isChanged,
    int? noteId,
    Note? selectedNote,
  }) {
    return NotesState(
      autoId: autoId ?? this.autoId,
      notesList: notesList ?? this.notesList,
      isChanged: isChanged ?? this.isChanged,
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
      'isChanged': isChanged,
      'selectedNote': selectedNote?.toMap(),
    };
  }

  factory NotesState.fromMap(Map<String, dynamic> map) {
    return NotesState(
      autoId: map['autoId'] as int,
      notesList: List<Note>.from(map['notesList']?.map((x) => Note.fromMap(x))),
      isChanged: map['isChanged'] as bool,
      selectedNote: map['selectedNote'] != null ? Note.fromMap(map['selectedNote']) : null,
    );
  }
}
