import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

enum WeekDay {
  mon,
  di,
  mi,
  don,
  fr,
  sa,
  so,
}

enum Month {
  jan,
  feb,
  maerz,
  mai,
  juni,
  juli,
  aug,
  sept,
  okt,
  nov,
  dez,
}

String capitalize(String name) {
  return '${name[0].toUpperCase()}${name.substring(1).toLowerCase()}';
}

String date() {
  return '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
}

//convert date object to string
String dateToString(DateTime date) {
  return '${date.day}.${date.month}.${date.year}';
}

// convert delta title object to string
String deltaTitleToString(Delta delta) {
  return delta.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '').replaceAll(RegExp('insert'), '');
}

//const kBackgroundColor = Color(0xffFFFFFF);
const kBackgroundColorDark = Color.fromARGB(255, 39, 39, 39);
const kBackgroundColorLight = Color(0xffF5F5F5);

//const TextStyle kNoteTitle = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
