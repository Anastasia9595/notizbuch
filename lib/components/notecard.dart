import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';

import '../cubit/theme_cubit/theme_cubit.dart';
import '../helpers/constants.dart';
import '../model/note.dart';
import '../view/textedit.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

  final bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    quill.QuillController titleController = quill.QuillController(
      document: quill.Document.fromDelta(note.title),
      selection: const TextSelection.collapsed(offset: 0),
    );
    quill.QuillController descriptionController = quill.QuillController(
      document: quill.Document.fromDelta(note.description),
      selection: const TextSelection.collapsed(offset: 0),
    );

    final themeState = context.watch<ThemeCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 150,
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: themeState.switchValue ? Colors.white.withOpacity(0.3) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(2, 2),
                  ),
                  BoxShadow(
                    color: themeState.switchValue ? Colors.white : Colors.black,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 33,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                child: Center(
                              child: Text(
                                capitalize(WeekDay.values[note.date.weekday - 1].name),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                '${note.date.day}',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                capitalize(Month.values[note.date.month - 2].name),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: quill.QuillEditor.basic(
                              controller: titleController,
                              readOnly: true, // true for view only mode
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: quill.QuillEditor.basic(
                              controller: descriptionController,
                              readOnly: true, // true for view only mode
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
