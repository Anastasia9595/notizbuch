import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/notes_cubit.dart';
import 'package:notizapp/view/home.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesCubit>().state;
    if (state.isChanged) {
      titleController.text = state.selectedNote!.title;
      descriptionController.text = state.selectedNote!.description;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFE9AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE9AE),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (titleController.text.isNotEmpty) {
              return IconButton(
                  onPressed: () {
                    if (state.isChanged == true) {
                      BlocProvider.of<NotesCubit>(context).updateNotefromList(
                        state.selectedNote!,
                        titleController.text,
                        descriptionController.text,
                      );
                      context.read<NotesCubit>().setIsChanged(false);

                      log('${state.selectedNote}');
                    } else {
                      BlocProvider.of<NotesCubit>(context)
                          .addNoteToList(titleController.text, descriptionController.text);
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((BuildContext context) => const Homepage()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.done));
            } else {
              return IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((BuildContext context) => const Homepage()),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              );
            }
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            textInputAction: TextInputAction.next,
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Title',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TextField(
              controller: descriptionController,
              maxLines: 30,
              minLines: 30,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.format_bold,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.format_italic, size: 30),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.format_underline,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.check_box_outlined,
                    size: 30,
                  ),
                ),
                IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.image,
                      size: 30,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
