part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final List<Note> favoriteNotes;
  final bool isPressed;

  const FavoritesState({required this.favoriteNotes, required this.isPressed});

  FavoritesState copyWith({
    List<Note>? favoriteNotes,
    bool? isPressed,
  }) {
    return FavoritesState(
      favoriteNotes: favoriteNotes ?? this.favoriteNotes,
      isPressed: isPressed ?? this.isPressed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favoriteNotes': favoriteNotes.map((e) => e.toMap()).toList(),
      'isPressed': isPressed,
    };
  }

  factory FavoritesState.fromMap(Map<String, dynamic> map) {
    return FavoritesState(
      favoriteNotes: List<Note>.from(
        map['favoriteNotes']?.map(
          (x) => Note.fromMap(x),
        ),
      ),
      isPressed: map['isPressed'] as bool,
    );
  }

  @override
  List<Object?> get props => [favoriteNotes, isPressed];
}
