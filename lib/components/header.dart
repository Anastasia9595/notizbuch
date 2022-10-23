import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notes_cubit/notes_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../helpers/constants.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.ascpectRatio, required this.crossAxisCount, required this.itemCount});
  final double ascpectRatio;
  final int crossAxisCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return AspectRatio(
      aspectRatio: 4,
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return GridView.builder(
                itemCount: itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              deltaTitleToString(state.notesList[index].title),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: quill.QuillEditor.basic(
                                controller: quill.QuillController(
                                  document: quill.Document.fromDelta(state.notesList[index].description),
                                  selection: const TextSelection.collapsed(offset: 0),
                                ),
                                readOnly: true, // true for view only mode
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
