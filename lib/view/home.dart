import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/components/dimissible_card.dart';
import 'package:notizapp/components/notecard.dart';

import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/helpers/constants.dart';

import 'package:notizapp/view/textedit.dart';

import '../components/alertdialog.dart';
import '../components/navigationdrawer.dart';
import '../components/searchbar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<NotesCubit>().setNotetoEdit(state.notesList[index]);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TextEditPage(),
                                ),
                              );
                            },
                            child: Center(
                              child: NoteCard(
                                note: state.notesList[index],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
              builder: ((BuildContext context) => const TextEditPage()),
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
