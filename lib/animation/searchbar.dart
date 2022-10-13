// ignore_for_file: sort_child_properties_last

import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';

import '../cubit/searchfield_cubit/searchfield_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

int toggle = 0;

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  AnimationController? _con;

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return Container(
      height: 80,
      width: 270,
      alignment: const Alignment(0.9, 0.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 270),
        height: 48.0,
        width: (toggle == 0) ? 45 : 300,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: themeState.themeMode == ThemeMode.light ? Colors.amber : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: themeState.themeMode == ThemeMode.light ? Colors.white70 : Colors.black54,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 6,
              left: 7,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: toggle == 0 ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // decoration: const BoxDecoration(color: Color(0xfff2f3f7)),
                  child: AnimatedBuilder(
                      child: const Icon(Icons.search),
                      animation: _con!,
                      builder: (context, widget) {
                        return Transform.rotate(
                          angle: _con!.value * 2.0 * m.pi,
                          child: widget,
                        );
                      }),
                ),
              ),
              duration: const Duration(microseconds: 37),
            ),
            AnimatedPositioned(
              left: toggle == 0 ? 20 : 40,
              top: 13,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: toggle == 0 ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  height: 23,
                  width: 180,
                  child: BlocBuilder<NotesCubit, NotesState>(builder: (context, noteState) {
                    return BlocBuilder<SearchfieldCubit, SearchfieldState>(
                      builder: (context, searchState) {
                        return TextField(
                          focusNode: searchState.focusNode,
                          controller: searchState.controller,
                          cursorRadius: const Radius.circular(10),
                          cursorWidth: 2,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Search...',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: const TextStyle(
                              color: Color(0xff5b5b5b),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            context.read<NotesCubit>().filterNotes(value);
                          },
                        );
                      },
                    );
                  }),
                ),
              ),
              duration: const Duration(milliseconds: 375),
            ),
            Material(
              color: themeState.themeMode == ThemeMode.light ? Colors.white : const Color(0xff282828),
              borderRadius: BorderRadius.circular(30),
              child: BlocBuilder<SearchfieldCubit, SearchfieldState>(builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      if (toggle == 0) {
                        toggle = 1;

                        _con!.forward();
                        state.controller.clear();
                      } else {
                        toggle = 0;
                        _con!.reverse();
                        context.read<NotesCubit>().resetList();
                        state.focusNode.unfocus();
                        state.controller.clear();
                      }
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: themeState.themeMode == ThemeMode.light ? Colors.black : Colors.white,
                    size: 26,
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
