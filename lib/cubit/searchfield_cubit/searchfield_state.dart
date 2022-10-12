part of 'searchfield_cubit.dart';

class SearchfieldState extends Equatable {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchfieldState({required this.controller, required this.focusNode});
  @override
  List<Object?> get props => [controller, focusNode];

  SearchfieldState copyWith({
    TextEditingController? controller,
    FocusNode? focusNode,
  }) {
    return SearchfieldState(
      controller: controller ?? this.controller,
      focusNode: focusNode ?? this.focusNode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'controller': controller.text,
      'focusNode': focusNode.hasFocus,
    };
  }

  // factory SearchfieldState.fromMap(Map<String, dynamic> map) {
  //   return SearchfieldState(
  //     controller: TextEditingController(text: map['controller'] as String),
  //     focusNode: FocusNode()..hasFocus = map['focusNode'] as bool,
  //   );
  // }
}
