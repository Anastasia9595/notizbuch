import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/searchfield_cubit/searchfield_cubit.dart';
import 'package:notizapp/helpers/constants.dart';

import '../cubit/notes_cubit/notes_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({super.key});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SearchfieldCubit, SearchfieldState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: state.folded ? 56 : size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: state.folded ? kBackgroundColorDark : Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<SearchfieldCubit, SearchfieldState>(
                  builder: (context, searchState) {
                    return Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: !searchState.folded
                          ? TextField(
                              focusNode: searchState.focusNode,
                              controller: searchState.controller,
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                context.read<NotesCubit>().filterNotes(value);
                              },
                            )
                          : null,
                    );
                  },
                ),
              ),
              BlocBuilder<SearchfieldCubit, SearchfieldState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(state.folded ? 32 : 0),
                          topRight: const Radius.circular(32),
                          bottomLeft: Radius.circular(state.folded ? 32 : 0),
                          bottomRight: const Radius.circular(32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            state.folded ? Icons.search : Icons.close,
                            color: state.folded ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () {
                          context.read<SearchfieldCubit>().setFolded(!state.folded);
                          state.controller.clear();
                          state.focusNode.unfocus();
                          context.read<NotesCubit>().resetList();
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
