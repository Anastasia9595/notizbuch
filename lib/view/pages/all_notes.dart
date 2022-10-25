import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/animation/new_searchbar.dart';
import 'package:notizapp/animation/searchbar.dart';
import 'package:notizapp/components/listtile.dart';
import 'package:notizapp/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/view/pages/textedit.dart';
import 'package:notizapp/view/screens/responsive_layout.dart';
import 'package:notizapp/view/screens/responsive_screens/desktop_screen.dart';
import 'package:notizapp/view/screens/responsive_screens/mobile_screen.dart';
import 'package:notizapp/view/screens/responsive_screens/tablet_screen.dart';

import '../../components/alertdialog.dart';
import '../../components/dimissible_card.dart';
import '../../components/notecard.dart';
import '../../cubit/archive_notes_cubit/archive_notes_cubit.dart';
import '../../cubit/searchfield_cubit/searchfield_cubit.dart';
import '../../cubit/theme_cubit/theme_cubit.dart';

class AllNotesPage extends StatelessWidget {
  const AllNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state.switchValue;
    return Scaffold(
      backgroundColor: themeState ? Colors.white : const Color(0xff282828),
      appBar: AppBar(
        backgroundColor: themeState ? Colors.white : const Color(0xff282828),
        elevation: 0.0,
        actions: const [
          AnimatedSearchBar(),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((BuildContext context) => const ResponsiveLayout(
                      mobileScaffold: MobileScreen(),
                      tabletScaffold: TabletScreen(),
                      desktopScaffold: DesktopScreen(),
                    )),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: themeState ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: Row(
            children: [
              BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Notizen (${state.notesList.length})',
                      style: TextStyle(
                        color: themeState ? Colors.black : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
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
                          isDragging: true,
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
                                      context
                                          .read<ArchiveNotesCubit>()
                                          .addNoteToArchiveList(notesState.notesList[index]);
                                      context.read<NotesCubit>().removeNotefromList(notesState.notesList[index].id);
                                      Navigator.of(context).pop();
                                    },
                                    title: 'Notiz archivieren',
                                    description: 'Möchtest du die Notiz wirklich archivieren?'));
                          },
                          children: [
                            BlocBuilder<NotesCubit, NotesState>(builder: (context, notesState) {
                              return BlocBuilder<SearchfieldCubit, SearchfieldState>(
                                builder: (context, searchState) {
                                  return InkWell(
                                    onTap: () {
                                      context.read<NotesCubit>().setNotetoEdit(
                                            notesState.notesList[index],
                                          );

                                      searchState.controller.clear();
                                      searchState.focusNode.unfocus();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const NotesEditPage(),
                                        ),
                                      );
                                    },
                                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                                      builder: (context, state) {
                                        return ListTileNote(
                                            id: searchState.focusNode.hasFocus == false ||
                                                    searchState.controller.text.isEmpty
                                                ? notesState.notesList[index].id
                                                : notesState.filteredNotesList[index].id);
                                      },
                                    ),
                                  );
                                },
                              );
                            }),
                          ]);
                    }),
                  );
                },
              );
            },
          ),
        ),
      ]),
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
                  builder: ((BuildContext context) => const NotesEditPage()),
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
