import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/animation/new_searchbar.dart';
import 'package:notizapp/presentation/components/dimissible_card.dart';
import 'package:notizapp/presentation/components/trash_listile.dart';
import 'package:notizapp/presentation/view/pages/textedit.dart';
import 'package:notizapp/presentation/view/screens/responsive_layout.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/desktop_screen.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/tablet_screen.dart';

import '../../../business_logic/cubits/favorites_cubit/favorites_cubit.dart';
import '../../../business_logic/cubits/trash_notes_cubit/trash_notes_cubit.dart';
import '../../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../../business_logic/cubits/searchfield_cubit/searchfield_cubit.dart';
import '../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../components/alrtdialog.dart';
import '../../components/listtile.dart';

class TrashNotePage extends StatelessWidget {
  const TrashNotePage({super.key});

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
                builder: ((BuildContext context) => ResponsiveLayout(
                      mobileScaffold: MobileScreen(),
                      tabletScaffold: const TabletScreen(),
                      desktopScaffold: const DesktopScreen(),
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
              BlocBuilder<TrashNotesCubit, TrashNotesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Gelöschte Notizen (${state.trashNotes.length})',
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
          child: BlocBuilder<TrashNotesCubit, TrashNotesState>(
            builder: (context, notesState) {
              return BlocBuilder<SearchfieldCubit, SearchfieldState>(
                builder: (context, searchState) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: !searchState.focusNode.hasFocus || searchState.controller.text.isEmpty
                        ? notesState.trashNotes.length
                        : notesState.filteredNotes.length,
                    itemBuilder: ((context, index) {
                      return DismissibleCard(
                        key: Key(
                          searchState.controller.text.isEmpty || !searchState.focusNode.hasFocus
                              ? notesState.trashNotes[index].toString()
                              : notesState.filteredNotes[index].toString(),
                        ),
                        swipe: () {
                          showDialog(
                            context: context,
                            builder: (context) => Alert(
                              backgroundColor: Colors.blueGrey.shade100,
                              iconColorWidget: Colors.black,
                              icon: Icons.delete,
                              iconColor: Colors.white.withOpacity(0.5),
                              title: 'Notiz löschen',
                              titleColor: Colors.black,
                              content: const Text('Möchten Sie wirklich diese Notiz löschen?'),
                              functions: [
                                () {
                                  Navigator.of(context).pop();
                                },
                                () {
                                  context
                                      .read<TrashNotesCubit>()
                                      .removeNotefromTrashList(notesState.trashNotes[index].id);

                                  Navigator.of(context).pop();
                                }
                              ],
                              functionNames: const ['NO', 'YES'],
                            ),
                          );
                        },
                        children: [
                          TrashListtile(
                              note: searchState.controller.text.isEmpty || !searchState.focusNode.hasFocus
                                  ? notesState.trashNotes[index]
                                  : notesState.filteredNotes[index]),
                        ],
                      );
                    }),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
