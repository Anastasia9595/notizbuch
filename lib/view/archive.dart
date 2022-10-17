import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/archive_notes_cubit/archive_notes_cubit.dart';

import 'package:notizapp/view/home.dart';

import '../components/alertdialog.dart';
import '../components/dimissible_card.dart';
import '../components/notecard.dart';
import '../cubit/notes_cubit/notes_cubit.dart';

class Archive extends StatelessWidget {
  const Archive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                style: TextStyle(fontSize: 30),
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
