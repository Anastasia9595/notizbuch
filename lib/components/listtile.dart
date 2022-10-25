import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/helpers/constants.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:tuple/tuple.dart';

import '../cubit/theme_cubit/theme_cubit.dart';
import '../helpers/functions.dart';
import '../model/note.dart';

class ListTileNote extends StatelessWidget {
  const ListTileNote({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    NotesState notesState = context.watch<NotesCubit>().state;
    Note newNote = notesState.notesList.firstWhere((element) => element.id == id);
    NotesCubit notescubit = context.read<NotesCubit>();
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    quill.QuillController descriptionController = quill.QuillController(
      document: quill.Document.fromDelta(newNote.description),
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
              deltaTitleToString(newNote.title),
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
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favoriteState) {
                    return BlocBuilder<NotesCubit, NotesState>(
                      builder: (context, noteState) {
                        return Expanded(
                          child: IconButton(
                              onPressed: () {
                                notescubit.setIsFavorite(newNote.id, !newNote.isFavorite);
                                log('setIsFavorite ${newNote.isFavorite}');
                                if (!newNote.isFavorite) {
                                  context.read<FavoritesCubit>().addNotetoFavoriteList(newNote);
                                } else {
                                  context.read<FavoritesCubit>().removeNotefromFavoriteList(newNote);
                                }
                              },
                              icon: newNote.isFavorite
                                  ? Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.star_border_outlined,
                                      color: Colors.white,
                                    )),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  ' ${newNote.date.day}. ${capitalize(Month.values[newNote.date.month - 2].name)} ',
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
