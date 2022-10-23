part of 'archive_notes_cubit.dart';

class ArchiveNotesState extends Equatable {
  final List<Note> archiveNotes;

  ArchiveNotesState({required this.archiveNotes});

  ArchiveNotesState copyWith({
    List<Note>? archiveNotes,
  }) {
    return ArchiveNotesState(archiveNotes: archiveNotes ?? this.archiveNotes);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'archiveNotes': archiveNotes.map((e) => e.toMap()).toList(),
    };
  }

  factory ArchiveNotesState.fromMap(Map<String, dynamic> map) {
    return ArchiveNotesState(
      archiveNotes: List<Note>.from(
        map['archiveNotes']?.map(
          (x) => Note.fromMap(x),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [archiveNotes];
}
