// ignore_for_file: sort_child_properties_last

import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/notes_cubit/notes_cubit.dart';
import 'package:notizapp/helpers/constants.dart';

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
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 270),
        height: 45.0,
        width: (toggle == 0) ? 45 : MediaQuery.of(context).size.width * 0.8,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: themeState.switchValue ? Colors.amber : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: themeState.switchValue ? Colors.white70 : Colors.black54,
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
                  child: AnimatedBuilder(
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
                opacity: toggle == 0 ? 0 : 0.5,
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  height: 20,
                  width: 190,
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
            Container(
              width: 45,
              decoration: BoxDecoration(
                color: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: themeState.switchValue ? kBackgroundColorLight : kBackgroundColorDark,
                  width: 1.5,
                ),
              ),
              child: BlocBuilder<SearchfieldCubit, SearchfieldState>(
                builder: (context, state) {
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
                      color: themeState.switchValue ? Colors.black : Colors.white,
                      size: 26,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
