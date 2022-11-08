import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/animation/new_searchbar.dart';

import 'package:notizapp/presentation/components/header.dart';

import '../../../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../../../business_logic/cubits/searchfield_cubit/searchfield_cubit.dart';
import '../../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../components/alertdialog.dart';
import '../../../components/dimissible_card.dart';
import '../../../components/navigationdrawer.dart';
import '../../../components/notecard.dart';

import '../../../../business_logic/helpers/constants.dart';
import '../../pages/textedit.dart';

class TabletScreen extends StatelessWidget {
  const TabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
      appBar: AppBar(
        backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
        elevation: 0.0,
        iconTheme: IconThemeData(color: themeState.switchValue ? kBackgroundColorDark : kBackgroundColorLight),
        actions: [
          const AnimatedSearchBar(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sync,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: NavigationDrawer(
        showButton: true,
      ),
      body: Column(
        children: [
          const Header(ascpectRatio: 4, crossAxisCount: 4, itemCount: 4),
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
                            swipe: () {
                              showDialog(
                                context: context,
                                builder: (context) => MyAlert(
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
                                            builder: (context) => const NotesEditPage(),
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
    );
  }
}
