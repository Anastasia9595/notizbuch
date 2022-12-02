import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:tuple/tuple.dart';
import '../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../business_logic/helpers/constants.dart';
import '../../business_logic/helpers/functions.dart';
import '../../data/model/note.dart';

class TrashListtile extends StatelessWidget {
  const TrashListtile({super.key, required this.note});
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
        color: kBackgroundColorDark,
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey.shade600),
        ),
      ),
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
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 5),
                  child: quill.QuillStyles(
                      data: quill.DefaultStyles(
                        paragraph: quill.DefaultTextBlockStyle(
                            TextStyle(color: themeState ? Colors.black : Colors.grey[300]),
                            const Tuple2(0, 0),
                            const Tuple2(0, 0),
                            null),
                      ),
                      child: quill.QuillEditor.basic(controller: descriptionController, readOnly: true)),
                ),
              ),
              Icon(
                note.isFavorite ? Icons.star : Icons.star_outline,
                color: Colors.white,
              )
            ],
          ))
        ],
      ),
    );
  }
}
