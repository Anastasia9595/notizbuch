part of 'searchfield_cubit.dart';

class SearchfieldState extends Equatable {
  final TextEditingController controller;
  final FocusNode focusNode;
  final AnimationController? con;

  const SearchfieldState({required this.controller, required this.focusNode, required this.con});
  @override
  List<Object?> get props => [controller, focusNode, con];

  SearchfieldState copyWith({
    TextEditingController? controller,
    FocusNode? focusNode,
    AnimationController? con,
  }) {
    return SearchfieldState(
      controller: controller ?? this.controller,
      focusNode: focusNode ?? this.focusNode,
      con: con ?? this.con,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'controller': controller.text,
  //     'focusNode': focusNode.hasFocus,
  //   };
  // }

  // factory SearchfieldState.fromMap(Map<String, dynamic> map) {
  //   return SearchfieldState(
  //     controller: TextEditingController(text: map['controller'] as String),
  //     focusNode: FocusNode()..hasFocus = map['focusNode'] as bool,
  //   );
  // }
}
