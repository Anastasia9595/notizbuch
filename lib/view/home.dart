import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/components/dimissible_card.dart';
import 'package:notizapp/components/notecard.dart';

import 'package:notizapp/cubit/notes_cubit.dart';
import 'package:notizapp/view/add_note.dart';

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
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm'),
                              content: const Text('Are you sure you wish to delete this item?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<NotesCubit>().removeNotefromList(state.notesList[index].id);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('Notiz erfolgreich gelöscht'),
                                      duration: Duration(seconds: 1),
                                    ));
                                  },
                                  child: const Text('CONFIRM'),
                                )
                              ],
                            ),
                          );
                        },
                        startToEnd: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm'),
                              content: const Text('Are you sure you wish to archive this item?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCEL'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CONFIRM'),
                                )
                              ],
                            ),
                          );
                        },
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<NotesCubit>().setNotetoEdit(state.notesList[index]);

                              context.read<NotesCubit>().setIsChanged(true);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNote(),
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((BuildContext context) => AddNote())));
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
