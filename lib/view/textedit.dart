import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;

import 'home.dart';

class TextEditPage extends StatefulWidget {
  const TextEditPage({super.key});

  @override
  State<TextEditPage> createState() => _TextEditPageState();
}

class _TextEditPageState extends State<TextEditPage> {
  // final _controllerTitle = QuillController.basic();
  // final _controllerDescription = QuillController.basic();
  q.QuillController titleController = q.QuillController.basic();
  q.QuillController descriptionController = q.QuillController.basic();

  @override
  void initState() {
    super.initState();
    final state = context.read<NotesCubit>().state;
    if (state.selectedNote!.id != 0) {
      titleController = q.QuillController(
        document: q.Document.fromDelta(state.selectedNote!.title),
        selection: const TextSelection.collapsed(offset: 0),
      );
      descriptionController = q.QuillController(
        document: q.Document.fromDelta(state.selectedNote!.description),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE9AE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFE9AE),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          leading: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    if (state.selectedNote!.id == 0 &&
                        !titleController.document.isEmpty() &&
                        !descriptionController.document.isEmpty()) {
                      BlocProvider.of<NotesCubit>(context)
                          .addNoteToList(titleController.document.toDelta(), descriptionController.document.toDelta());
                    } else if (state.selectedNote!.id != 0 &&
                            titleController.document.toDelta() != state.selectedNote!.title ||
                        descriptionController.document.toDelta() != state.selectedNote!.description) {
                      BlocProvider.of<NotesCubit>(context).updateNotefromList(
                        state.selectedNote!,
                        titleController.document.toDelta(),
                        descriptionController.document.toDelta(),
                      );
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((BuildContext context) => const Homepage()),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ));
            },
          ),
        ),
        body: Column(
          children: [
            // Title
            Container(
              alignment: Alignment.center,
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: q.QuillEditor.basic(
                  controller: titleController,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Description
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: q.QuillEditor.basic(
                    controller: descriptionController,
                    readOnly: false, // true for view only mode
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  q.QuillToolbar.basic(
                    controller: descriptionController,
                    showCodeBlock: false,
                    showAlignmentButtons: false,
                    showClearFormat: false,
                    showHeaderStyle: false,
                    showLink: false,
                    showQuote: false,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
