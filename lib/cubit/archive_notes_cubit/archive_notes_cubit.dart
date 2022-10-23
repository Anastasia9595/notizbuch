import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:notizapp/model/note.dart';

part 'archive_notes_state.dart';

class ArchiveNotesCubit extends Cubit<ArchiveNotesState> with HydratedMixin {
  ArchiveNotesCubit() : super(ArchiveNotesState(archiveNotes: const [])) {
    hydrate();
  }

  void addNoteToArchiveList(Note note) {
    emit(
      state.copyWith(
        archiveNotes: [note, ...state.archiveNotes],
      ),
    );
  }

  // remove note from list
  void removeNotefromArchiveList(int id) {
    emit(
      state.copyWith(
        archiveNotes: state.archiveNotes.where((element) => element.id != id).toList(),
      ),
    );
  }

  @override
  ArchiveNotesState? fromJson(Map<String, dynamic> json) {
    return ArchiveNotesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ArchiveNotesState state) {
    return state.toMap();
  }
}
