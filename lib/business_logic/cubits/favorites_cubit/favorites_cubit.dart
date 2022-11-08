import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/model/note.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> with HydratedMixin {
  FavoritesCubit()
      : super(const FavoritesState(
          favoriteNotes: [],
          isPressed: false,
        ));

  void addNotetoFavoriteList(Note note) {
    final list = state.favoriteNotes;
    List<Note> newList = [];
    if (!list.contains(note)) {
      newList = [note, ...list];
    } else {
      newList = [...list];
    }

    emit(
      state.copyWith(favoriteNotes: newList),
    );
  }

  void removeNotefromFavoriteList(Note note) {
    emit(
      state.copyWith(
        favoriteNotes: state.favoriteNotes.where((element) => element.id != note.id).toList(),
      ),
    );
  }

  void setIsPressed(bool value) {
    emit(state.copyWith(isPressed: value));
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    return FavoritesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return state.toMap();
  }
}
