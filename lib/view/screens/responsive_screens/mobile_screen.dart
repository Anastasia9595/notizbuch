import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notizapp/components/navigationdrawer.dart';
import 'package:notizapp/components/header_mobile.dart';
import 'package:notizapp/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:notizapp/view/pages/all_notes.dart';

import '../../../cubit/notes_cubit/notes_cubit.dart';

import '../../../cubit/theme_cubit/theme_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
              elevation: 0.0,
              iconTheme: IconThemeData(color: themeState.switchValue ? kBackgroundColorDark : kBackgroundColorLight),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sync,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 30),
              child: RichText(
                text: TextSpan(
                  text: 'Hello',
                  style: const TextStyle(color: Colors.white, fontSize: 50),
                  children: [
                    TextSpan(
                        text: '\n${DateTime.now().day}. ${capitalize(Month.values[DateTime.now().month - 2].name)}',
                        style: const TextStyle(color: Colors.white, fontSize: 20))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(
        showButton: true,
      ),
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 15),
                  child: TextButton(
                    child: Row(
                      children: [
                        Text(
                          'Alle Notizen (${context.watch<NotesCubit>().state.notesList.length})',
                          style: TextStyle(
                              color: themeState.switchValue ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.amber,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllNotesPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
                          fontSize: 20),
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
            SizedBox(
              height: closeTopContainer ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      'Favoriten',
                      style: TextStyle(
                          color: themeState.switchValue ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  BlocBuilder<FavoritesCubit, FavoritesState>(
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
                              itemCount: state.favoriteNotes.length,
                              itemBuilder: (context, index) {
                                if (index < 5) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                                    child: InkWell(child: HeaderMobile(note: state.favoriteNotes[index])),
                                  );
                                }
                                return Container();
                              }),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
