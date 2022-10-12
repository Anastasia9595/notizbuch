import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/model/note.dart';

part 'archive_notes_state.dart';

class ArchiveNotesCubit extends Cubit<ArchiveNotesState> {
  ArchiveNotesCubit() : super(ArchiveNotesState(archiveNotes: const []));

  void addNoteToArchiveList(Note note) {
    emit(
      state.copyWith(
        archiveNotes: [note, ...state.archiveNotes],
      ),
    );
  }

  void removeNotefromArchiveList(Note note) {
    emit(
      state.copyWith(
        archiveNotes: state.archiveNotes.where((element) => element.id != note.id).toList(),
      ),
    );
  }
}
