part of 'trash_notes_cubit.dart';

class TrashNotesState extends Equatable {
  final List<Note> trashNotes;
  final List<Note> filteredNotes;

  const TrashNotesState({required this.trashNotes, required this.filteredNotes});

  TrashNotesState copyWith({
    List<Note>? trashNotes,
    List<Note>? filteredNotes,
  }) {
    return TrashNotesState(
        trashNotes: trashNotes ?? this.trashNotes, filteredNotes: filteredNotes ?? this.filteredNotes);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'archiveNotes': trashNotes.map((e) => e.toMap()).toList(),
      'filteredNotes': filteredNotes.map((e) => e.toMap()).toList(),
    };
  }

  factory TrashNotesState.fromMap(Map<String, dynamic> map) {
    return TrashNotesState(
      filteredNotes: List<Note>.from(
        map['filteredNotes']?.map(
          (x) => Note.fromMap(x),
        ),
      ),
      trashNotes: List<Note>.from(
        map['archiveNotes']?.map(
          (x) => Note.fromMap(x),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [trashNotes, filteredNotes];
}
