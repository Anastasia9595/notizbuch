import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/components/dimissible_card.dart';
import 'package:notizapp/components/notecard.dart';

import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/view/add_note.dart';

import '../components/alertdialog.dart';
import '../components/navigationdrawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              return Text(
                'Alle Notizen (${state.notesList.length})',
                style: const TextStyle(fontSize: 30),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.notesList.length,
                  itemBuilder: ((context, index) {
                    return DismissibleCard(
                        key: Key(state.notesList[index].toString()),
                        endToStart: () {
                          showDialog(
                            context: context,
                            builder: (context) => Alert(
                              title: 'Notiz löschen',
                              description: 'Möchtest du die Notiz wirklich löschen?',
                              onPressed: () {
                                context.read<NotesCubit>().removeNotefromList(state.notesList[index].id);
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
                          InkWell(
                            onTap: () {
                              context.read<NotesCubit>().setNotetoEdit(state.notesList[index]);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddNote(),
                                ),
                              );
                            },
                            child: NoteCard(
                              note: state.notesList[index],
                            ),
                          ),
                        ]);
                  }),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NotesCubit>().cleanSelectedNote();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((BuildContext context) => const AddNote()),
            ),
          );
        },
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
