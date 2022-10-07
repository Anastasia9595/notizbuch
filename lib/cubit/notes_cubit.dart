import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notizapp/model/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> with HydratedMixin {
  NotesCubit() : super(const NotesState(notesList: [], autoId: 0, isChanged: false));

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

  void updateNotefromList(
    int id,
    String title,
    String description,
  ) {
    final Note note = Note(id: id, title: title, description: description, date: DateTime.now(), done: false);
    // final stateList = state.notesList;
    // final int index = stateList.indexWhere(((element) => element.id == id));
    // final newUpdatetState = stateList[index] = note;
    // stateList.remove(stateList[index]);
    // stateList.insert(index, note);
    // emit(state.copyWith(notesList: stateList));
    emit(state.copyWith(notesList: state.notesList.map((element) => element.id == id ? note : element).toList()));
  }

  void setIsChanged(bool isChanged) {
    emit(state.copyWith(isChanged: isChanged));
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
