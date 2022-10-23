import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/helpers/constants.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:tuple/tuple.dart';

import '../cubit/theme_cubit/theme_cubit.dart';
import '../model/note.dart';

class ListTileNote extends StatelessWidget {
  const ListTileNote({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    quill.QuillController descriptionController = quill.QuillController(
      document: quill.Document.fromDelta(note.description),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return Container(
      decoration: BoxDecoration(
          color: kBackgroundColorDark, border: Border(bottom: BorderSide(width: 1.5, color: Colors.grey.shade600))),
      height: MediaQuery.of(context).size.height * 0.20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              deltaTitleToString(note.title),
              style:
                  TextStyle(fontSize: 20, color: themeState ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: quill.QuillEditor(
                  focusNode: FocusNode(),
                  scrollController: ScrollController(),
                  scrollable: false,
                  padding: const EdgeInsets.all(0),
                  autoFocus: false,
                  expands: false,
                  controller: descriptionController,
                  readOnly: true,
                  customStyles: quill.DefaultStyles(
                    paragraph: quill.DefaultTextBlockStyle(
                        TextStyle(color: themeState ? Colors.black : Colors.grey[300]),
                        const Tuple2(0, 0),
                        const Tuple2(0, 0),
                        null),
                  ) // true for view only mode
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  ' ${note.date.day}. ${capitalize(Month.values[note.date.month - 2].name)} ',
                  style: TextStyle(color: themeState ? Colors.black : Colors.grey[300]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
