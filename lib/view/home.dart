import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/components/dimissible_card.dart';
import 'package:notizapp/components/notecard.dart';

import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/cubit/searchfield_cubit/searchfield_cubit.dart';
import 'package:notizapp/helpers/constants.dart';

import 'package:notizapp/view/textedit.dart';

import '../components/alertdialog.dart';
import '../components/navigationdrawer.dart';
import '../animation/searchbar.dart';
import '../cubit/theme_cubit/theme_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: themeState.themeMode == ThemeMode.light ? Colors.white : Color(0xff282828),
      appBar: AppBar(
        backgroundColor: themeState.themeMode == ThemeMode.light ? Colors.white : Color(0xff282828),
        elevation: 0.0,
        iconTheme: IconThemeData(color: themeState.themeMode == ThemeMode.light ? Colors.black : Colors.white),
        actions: [
          const SearchBar(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cloud_upload,
              size: 30,
            ),
          )
        ],
      ),
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          BlocBuilder<SearchfieldCubit, SearchfieldState>(
            builder: (context, searchfieldState) {
              return BlocBuilder<NotesCubit, NotesState>(
                builder: (context, notesState) {
                  return searchfieldState.focusNode.hasFocus == false || searchfieldState.controller.text.isEmpty
                      ? Text(
                          'Alle Notizen (${notesState.notesList.length})',
                          style: TextStyle(
                              fontSize: 30,
                              color: themeState.themeMode == ThemeMode.light ? Colors.black : Colors.white),
                        )
                      : Text(
                          'Suchergebnisse (${notesState.filteredNotesList.length})',
                          style: TextStyle(
                              fontSize: 30,
                              color: themeState.themeMode == ThemeMode.light ? Colors.black : Colors.white),
                        );
                },
              );
            },
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, notesState) {
                return BlocBuilder<SearchfieldCubit, SearchfieldState>(
                  builder: (context, searchState) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: !searchState.focusNode.hasFocus || searchState.controller.text.isEmpty
                          ? notesState.notesList.length
                          : notesState.filteredNotesList.length,
                      itemBuilder: ((context, index) {
                        return DismissibleCard(
                            key: Key(
                              searchState.controller.text.isEmpty || !searchState.focusNode.hasFocus
                                  ? notesState.notesList[index].toString()
                                  : notesState.filteredNotesList[index].toString(),
                            ),
                            endToStart: () {
                              showDialog(
                                context: context,
                                builder: (context) => Alert(
                                  title: 'Notiz löschen',
                                  description: 'Möchtest du die Notiz wirklich löschen?',
                                  onPressed: () {
                                    context.read<NotesCubit>().removeNotefromList(
                                        searchState.controller.text.isEmpty || !searchState.focusNode.hasFocus
                                            ? notesState.notesList[index].id
                                            : notesState.filteredNotesList[index].id);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            startToEnd: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Alert(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      title: 'Notiz archivieren',
                                      description: 'Möchtest du die Notiz wirklich archivieren?'));
                            },
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<NotesCubit, NotesState>(builder: (context, notesState) {
                                return BlocBuilder<SearchfieldCubit, SearchfieldState>(
                                  builder: (context, searchState) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<NotesCubit>().setNotetoEdit(
                                            searchState.controller.text.isEmpty || !searchState.focusNode.hasFocus
                                                ? notesState.notesList[index]
                                                : notesState.filteredNotesList[index]);

                                        searchState.controller.clear();
                                        searchState.focusNode.unfocus();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const TextEditPage(),
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: NoteCard(
                                            note: searchState.focusNode.hasFocus == false ||
                                                    searchState.controller.text.isEmpty
                                                ? notesState.notesList[index]
                                                : notesState.filteredNotesList[index]),
                                      ),
                                    );
                                  },
                                );
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                            ]);
                      }),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<SearchfieldCubit, SearchfieldState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<NotesCubit>().cleanSelectedNote();
              state.controller.clear();
              state.focusNode.unfocus();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((BuildContext context) => const TextEditPage()),
                ),
              );
            },
            backgroundColor: Colors.amber,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
