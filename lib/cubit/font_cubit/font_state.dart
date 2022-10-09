part of 'font_cubit.dart';

class FontState extends Equatable {
  final bool boldFont;
  final bool italicFont;
  final bool underlineFont;
  final bool checkBox;

  FontState({
    required this.boldFont,
    required this.italicFont,
    required this.underlineFont,
    required this.checkBox,
  });
  @override
  List<Object?> get props => [boldFont, italicFont, underlineFont, checkBox];

  FontState copyWith({
    bool? boldFont,
    bool? italicFont,
    bool? underlineFont,
    bool? checkBox,
    Image? image,
  }) {
    return FontState(
      boldFont: boldFont ?? this.boldFont,
      italicFont: italicFont ?? this.italicFont,
      underlineFont: underlineFont ?? this.underlineFont,
      checkBox: checkBox ?? this.checkBox,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boldFont': boldFont,
      'italicFont': italicFont,
      'underlineFont': underlineFont,
      'checkBox': checkBox,
    };
  }
}
