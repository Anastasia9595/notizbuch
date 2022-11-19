import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../business_logic/helpers/constants.dart';
import '../../business_logic/helpers/functions.dart';
import '../../data/model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

  final bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    quill.QuillController descriptionController = quill.QuillController(
      document: quill.Document.fromDelta(note.description),
      selection: const TextSelection.collapsed(offset: 0),
    );

    final themeState = context.watch<ThemeCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150,
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: themeState.switchValue ? Colors.white : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: themeState.switchValue
                    ? [
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
                      ]
                    : [
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.8),
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
                            child: Text(
                              deltaTitleToString(note.title),
                              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
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
