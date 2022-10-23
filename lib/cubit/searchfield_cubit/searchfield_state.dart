part of 'searchfield_cubit.dart';

class SearchfieldState extends Equatable {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool folded;

  const SearchfieldState({required this.controller, required this.focusNode, required this.folded});
  @override
  List<Object?> get props => [controller, focusNode, folded];

  SearchfieldState copyWith({
    TextEditingController? controller,
    FocusNode? focusNode,
    bool? folded,
  }) {
    return SearchfieldState(
      controller: controller ?? this.controller,
      focusNode: focusNode ?? this.focusNode,
      folded: folded ?? this.folded,
    );
  }
}
