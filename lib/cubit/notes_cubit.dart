import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notizapp/model/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> with HydratedMixin {
  NotesCubit()
      : super(NotesState(
            notesList: const [],
            autoId: 0,
            isChanged: false,
            selectedNote: Note(
              id: 0,
              date: DateTime.now(),
              done: false,
              title: '',
              description: '',
            )));

  void addNoteToList(
    String title,
    String description,
  ) {
    Note newNote = Note(
      id: state.autoId + 1,
      title: title,
      description: description,
      date: DateTime.now(),
      done: false,
    );

    emit(state.copyWith(
      autoId: state.autoId + 1,
      notesList: [newNote, ...state.notesList],
    ));
  }

  void removeNotefromList(int id) {
    emit(
      state.copyWith(
        notesList: state.notesList.where((element) => element.id != id).toList(),
      ),
    );
  }

  // Update Item in List by ID and save it
  void updateNotefromList(
    Note note,
    String title,
    String description,
  ) {
    Note newNote = note.copyWith(
      title: title,
      description: description,
      date: DateTime.now(),
    );

    emit(
      state.copyWith(
        notesList: state.notesList.map((element) => element.id == note.id ? element = newNote : element).toList(),
      ),
    );
  }

  void setIsChanged(bool isChanged) {
    emit(state.copyWith(isChanged: isChanged));
  }

  void setNotetoEdit(Note note) {
    emit(state.copyWith(selectedNote: note));
  }

  // clean the note to edit
  void cleanNotetoEdit(Note note) {
    emit(state.copyWith(selectedNote: note.copyWith(title: '', description: '')));
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toMap();
  }
}
