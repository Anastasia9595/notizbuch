import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/presentation/animation/new_searchbar.dart';
import 'package:notizapp/presentation/view/pages/textedit.dart';
import 'package:notizapp/presentation/view/screens/responsive_layout.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/desktop_screen.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/mobile_screen.dart';
import 'package:notizapp/presentation/view/screens/responsive_screens/tablet_screen.dart';

import '../../../business_logic/cubits/trash_notes_cubit/trash_notes_cubit.dart';
import '../../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../../business_logic/cubits/searchfield_cubit/searchfield_cubit.dart';
import '../../../business_logic/cubits/theme_cubit/theme_cubit.dart';

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
