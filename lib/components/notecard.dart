import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../helpers/constants.dart';
import '../model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

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
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: SizedBox(
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 33,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Expanded(
                            child: Center(
                          child: Text(
                            capitalize(WeekDay.values[note.date.weekday - 1].name),
                            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                          ),
                        )),
                        Expanded(
                            child: Center(
                          child: Text(
                            '${note.date.day}',
                            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                          ),
                        )),
                        Expanded(
                            child: Center(
                          child: Text(
                            capitalize(Month.values[note.date.month - 2].name),
                            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
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
        ),
      ),
    );
  }
}
