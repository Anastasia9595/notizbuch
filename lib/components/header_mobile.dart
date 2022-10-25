// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../cubit/theme_cubit/theme_cubit.dart';
import '../helpers/constants.dart';
import '../helpers/functions.dart';
import '../model/note.dart';

class HeaderMobile extends StatelessWidget {
  const HeaderMobile({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    quill.QuillController descriptionController = quill.QuillController(
      document: quill.Document.fromDelta(note.description),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10, left: 10),
      height: categoryHeight,
      decoration: BoxDecoration(
        boxShadow: themeState.switchValue
            ? [
                BoxShadow(
                  color: Colors.grey.shade600,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  color: themeState.switchValue ? Colors.white : Colors.black,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(-2, -2),
                ),
              ]
            : [
                BoxShadow(
                  offset: const Offset(-2, 4),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.8),
                ),
              ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deltaTitleToString(note.title),
              style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: quill.QuillEditor.basic(
                controller: descriptionController,
                readOnly: true, // true for view only mode
              ),
            ),
          ],
        ),
      ),
    );
  }
}
