import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/business_logic/cubits/login_cubit/login_cubit.dart';
import 'package:notizapp/business_logic/cubits/login_cubit/login_state.dart';

import 'package:notizapp/presentation/components/navigationdrawer.dart';
import 'package:notizapp/presentation/components/header_mobile.dart';
import 'package:notizapp/presentation/view/pages/all_notes.dart';

import '../../../../business_logic/cubits/favorites_cubit/favorites_cubit.dart';
import '../../../../business_logic/cubits/notes_cubit/notes_cubit.dart';
import '../../../../business_logic/cubits/theme_cubit/theme_cubit.dart';
import '../../../../business_logic/helpers/constants.dart';
import '../../../../business_logic/helpers/functions.dart';

class MobileScreen extends StatefulWidget {
  MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  void signOut(BuildContext context) {
    context.read<LoginCubit>().signOut();
  }

  String userNames = '';

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _fetchData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).get().then((value) {
        userNames = value.data()!['name'];
      }).catchError((e) {
        log(e);
      });
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    super.initState();
    if (user != null) {
      log(user.uid.toString());
    } else {
      log('user is null');
    }

    _fetchData();
  }

  ScrollController controller = ScrollController();

  bool closeTopContainer = false;

  double topContainer = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.3;

    final themeState = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
      drawer: NavigationDrawer(
        showButton: true,
      ),
      body: NestedScrollView(
        controller: controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          SliverAppBar(
            iconTheme: const IconThemeData(color: kBackgroundColorLight),
            actions: [
              IconButton(
                onPressed: () => signOut(context),
                icon: const Icon(
                  Icons.arrow_circle_left,
                  size: 30,
                ),
              ),
            ],
            backgroundColor: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
            expandedHeight: 200.0,
            floating: true,
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 15, bottom: 15),
              centerTitle: false,
              title: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return FutureBuilder(
                    future: _fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return RichText(
                          text: TextSpan(
                            text: 'Hello ${userNames.toString()}',
                            style: const TextStyle(color: Colors.white, fontSize: 25),
                            children: [
                              TextSpan(
                                  text:
                                      '\n${DateTime.now().day}. ${capitalize(Month.values[DateTime.now().month - 2].name)}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20))
                            ],
                          ),
                        );
                      }
                      return const Text('Loading...');
                    },
                  );
                },
              ),
              background: Image.asset(
                "assets/background.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: SizedBox(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
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

                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<NotesCubit, NotesState>(
                        builder: (context, state) {
                          return Container(
                            width: size.width,
                            height: categoryHeight,
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
                          );
                        },
                      ),
                    )
                  ],
                ),

                // Favorite
                SizedBox(
                  height: 50,
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

                Row(
                  children: [
                    BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: size.width,
                          height: categoryHeight,
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
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
