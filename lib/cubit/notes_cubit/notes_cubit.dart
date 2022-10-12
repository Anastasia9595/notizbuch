import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notizapp/model/note.dart';
import 'package:notizapp/view/textedit.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> with HydratedMixin {
  NotesCubit()
      : super(
          NotesState(
            notesList: const [],
            autoId: 0,
            selectedNote: Note(
              id: 0,
              title: Delta(),
              description: Delta(),
              date: DateTime.now(),
              done: false,
            ),
            filteredNotesList: const [],
          ),
        );

  // add note to list
  void addNoteToList(
    Delta title,
    Delta description,
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

  // remove note from list
  void removeNotefromList(int id) {
    emit(
      state.copyWith(
        notesList: state.notesList.where((element) => element.id != id).toList(),
        filteredNotesList: state.filteredNotesList.where((element) => element.id != id).toList(),
      ),
    );
  }

  // Update Item in List by ID and save it
  void updateNotefromList(
    Note note,
    Delta title,
    Delta description,
  ) {
    Note newNote = note.copyWith(
      title: title,
      description: description,
      date: DateTime.now(),
    );

    List<Note> notesList = state.notesList;
    final newList = notesList.map((element) => element.id == note.id ? element = newNote : element).toList();
    newList.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        notesList: newList,
      ),
    );
  }

  // clean selected Note
  void cleanSelectedNote() {
    emit(
      state.copyWith(
        selectedNote: Note(
          id: 0,
          title: Delta(),
          description: Delta(),
          date: DateTime.now(),
          done: false,
        ),
      ),
    );
  }

  // set selected Note
  void setNotetoEdit(Note note) {
    emit(state.copyWith(selectedNote: note));
  }

  // filter notes by name
  void filterNotes(String name) {
    List<Note> notesList = state.notesList;
    List<Note> filteredList =
        notesList.where((element) => element.title.toString().toLowerCase().contains(name.toLowerCase())).toList();

    emit(state.copyWith(filteredNotesList: filteredList));
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
