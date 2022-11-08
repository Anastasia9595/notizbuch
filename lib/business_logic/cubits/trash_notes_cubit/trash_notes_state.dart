part of 'trash_notes_cubit.dart';

class TrashNotesState extends Equatable {
  final List<Note> trashNotes;

  const TrashNotesState({required this.trashNotes});

  TrashNotesState copyWith({
    List<Note>? trashNotes,
  }) {
    return TrashNotesState(trashNotes: trashNotes ?? this.trashNotes);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'archiveNotes': trashNotes.map((e) => e.toMap()).toList(),
    };
  }

  factory TrashNotesState.fromMap(Map<String, dynamic> map) {
    return TrashNotesState(
      trashNotes: List<Note>.from(
        map['archiveNotes']?.map(
          (x) => Note.fromMap(x),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [trashNotes];
}
