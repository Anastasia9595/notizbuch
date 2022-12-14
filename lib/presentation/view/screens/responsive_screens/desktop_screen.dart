import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/components/navigationdrawer.dart';

import '../../../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../../../business_logic/cubits/searchfield_cubit/searchfield_cubit.dart';
import '../../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../components/alertdialog.dart';
import '../../../components/dimissible_card.dart';
import '../../../components/notecard.dart';

import '../../../../business_logic/helpers/constants.dart';
import '../../pages/textedit.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
      body: Row(
        children: [
          NavigationDrawer(
            showButton: false,
          ),
          Expanded(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
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
                            ),
                          );
                        }),
                  ),
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
                                swipe: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => MyAlert(
                                      title: 'Notiz l??schen',
                                      description: 'M??chtest du die Notiz wirklich l??schen?',
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
                                ],
                              );
                            }),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                          child: NotesEditPage(
                        showBackButton: false,
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
