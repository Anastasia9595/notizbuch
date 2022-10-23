import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/archive_notes_cubit/archive_notes_cubit.dart';

import 'package:notizapp/view/pages/home.dart';

import '../../components/alertdialog.dart';
import '../../components/dimissible_card.dart';
import '../../components/notecard.dart';
import '../../cubit/theme_cubit/theme_cubit.dart';

class Trash extends StatelessWidget {
  const Trash({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: themeState.switchValue ? Colors.white : const Color(0xff282828),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 30,
          ),
        ),
        backgroundColor: themeState.switchValue ? Colors.white : const Color(0xff282828),
        elevation: 0.0,
        iconTheme: IconThemeData(color: themeState.switchValue ? Colors.black : Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ArchiveNotesCubit, ArchiveNotesState>(
            builder: (context, state) {
              return Text(
                'Archivierte Notizen (${state.archiveNotes.length})',
                style: TextStyle(fontSize: 30, color: themeState.switchValue ? Colors.black : Colors.white),
              );
            },
          ),
          BlocBuilder<ArchiveNotesCubit, ArchiveNotesState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.archiveNotes.length,
                    itemBuilder: ((context, index) {
                      return DismissibleCard(
                          key: Key(
                            state.archiveNotes[index].id.toString(),
                          ),
                          isDragging: false,
                          endToStart: () {
                            showDialog(
                              context: context,
                              builder: (context) => Alert(
                                title: 'Notiz löschen',
                                description: 'Möchtest du die Notiz wirklich löschen?',
                                onPressed: () {
                                  context
                                      .read<ArchiveNotesCubit>()
                                      .removeNotefromArchiveList(state.archiveNotes[index].id);
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
                            Center(
                              child: NoteCard(
                                note: state.archiveNotes[index],
                              ),
                            ),
                          ]);
                    })),
              );
            },
          )
        ],
      ),
    );
  }
}
