import 'package:tuple/tuple.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;

import '../cubit/theme_cubit/theme_cubit.dart';
import 'home.dart';

class TextEditPage extends StatefulWidget {
  const TextEditPage({super.key});

  @override
  State<TextEditPage> createState() => _TextEditPageState();
}

class _TextEditPageState extends State<TextEditPage> {
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
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    return Scaffold(
        backgroundColor: themeState ? const Color(0xFFFFE9AE) : const Color(0xFF282828),
        appBar: AppBar(
          backgroundColor: themeState ? const Color(0xFFFFE9AE) : const Color(0xFF282828),
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: themeState ? Colors.black : Colors.white,
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
                border: Border(
                  bottom: BorderSide(
                    color: themeState ? Colors.black26 : Colors.white,
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 0),
                child: q.QuillEditor(
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: FocusNode(),
                  autoFocus: false,
                  placeholder: 'Add Title...',
                  expands: true,
                  padding: const EdgeInsets.only(top: 0),
                  controller: titleController,
                  readOnly: false,
                  customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                          TextStyle(
                              color: themeState ? Colors.black : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          const Tuple2(0, 0),
                          const Tuple2(0, 0),
                          null),
                      placeHolder: DefaultTextBlockStyle(const TextStyle(color: Colors.grey, fontSize: 20),
                          const Tuple2(0, 0), const Tuple2(0, 0), null)), // true for view only mode
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Description
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: q.QuillEditor(
                  showCursor: true,
                  scrollController: ScrollController(),
                  scrollable: true,
                  focusNode: FocusNode(),
                  autoFocus: false,
                  placeholder: 'Add Description...',
                  expands: true,
                  padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4, top: 15),
                  controller: descriptionController,
                  readOnly: false,
                  customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(TextStyle(color: themeState ? Colors.black : Colors.white),
                          const Tuple2(0, 8), const Tuple2(0, 0), null),
                      placeHolder: DefaultTextBlockStyle(const TextStyle(color: Colors.grey, fontSize: 16),
                          const Tuple2(0, 0), const Tuple2(0, 0), null)),

                  // true for view only mode
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  q.QuillToolbar.basic(
                    iconTheme: QuillIconTheme(
                      iconUnselectedFillColor: Colors.transparent,
                      iconUnselectedColor: themeState ? Colors.black : Colors.white,
                      iconSelectedColor: themeState ? Colors.deepOrange : Colors.amber,
                      iconSelectedFillColor: Colors.transparent,
                      disabledIconColor: themeState ? Colors.black : Colors.white,
                    ),
                    controller: descriptionController,
                    toolbarSectionSpacing: 3,
                    showFontFamily: false,
                    showFontSize: false,
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
