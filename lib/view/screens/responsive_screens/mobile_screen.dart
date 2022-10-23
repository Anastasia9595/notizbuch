import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notizapp/components/navigationdrawer.dart';
import 'package:notizapp/components/header_mobile.dart';

import '../../../animation/searchbar.dart';
import '../../../components/alertdialog.dart';
import '../../../components/dimissible_card.dart';
import '../../../components/notecard.dart';
import '../../../cubit/archive_notes_cubit/archive_notes_cubit.dart';
import '../../../cubit/notes_cubit/notes_cubit.dart';
import '../../../cubit/searchfield_cubit/searchfield_cubit.dart';
import '../../../cubit/theme_cubit/theme_cubit.dart';
import '../../../helpers/constants.dart';
import '../../pages/textedit.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  ScrollController controller = ScrollController();

  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.25;

    final themeState = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
      appBar: AppBar(
        backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
        elevation: 0.0,
        iconTheme: IconThemeData(color: themeState.switchValue ? kBackgroundColorDark : kBackgroundColorLight),
        actions: [
          const SearchBar(),
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
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            // Header
            SizedBox(
              height: closeTopContainer ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      'Zuletzt bearbeitet',
                      style: TextStyle(
                          color: themeState.switchValue ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      return AnimatedOpacity(
                        opacity: closeTopContainer ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedContainer(
                          width: size.width,
                          duration: const Duration(microseconds: 200),
                          height: closeTopContainer ? 0 : categoryHeight,
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.notesList.length,
                              itemBuilder: (context, index) {
                                if (index < 5) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                                    child: InkWell(child: HeaderMobile(note: state.notesList[index])),
                                  );
                                }
                                return Container();
                              }),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            // Noteslist
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 15),
                  child: Text(
                    'Alle Notizen (${context.watch<NotesCubit>().state.notesList.length})',
                    style: TextStyle(
                        color: themeState.switchValue ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 30),
                  ),
                ),
              ],
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
