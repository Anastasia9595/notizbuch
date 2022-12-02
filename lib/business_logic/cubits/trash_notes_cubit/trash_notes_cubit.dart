import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:notizapp/data/model/note.dart';

part 'trash_notes_state.dart';

class TrashNotesCubit extends Cubit<TrashNotesState> with HydratedMixin {
  TrashNotesCubit() : super(const TrashNotesState(trashNotes: [], filteredNotes: [])) {
    hydrate();
  }

  void addNoteToTrashList(Note note) {
    emit(
      state.copyWith(
        trashNotes: [note, ...state.trashNotes],
      ),
    );
  }

  // remove note from list
  void removeNotefromTrashList(int id) {
    emit(
      state.copyWith(
        trashNotes: state.trashNotes.where((element) => element.id != id).toList(),
        filteredNotes: state.filteredNotes.where((element) => element.id != id).toList(),
      ),
    );
  }

  @override
  TrashNotesState? fromJson(Map<String, dynamic> json) {
    return TrashNotesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TrashNotesState state) {
    return state.toMap();
  }
}
