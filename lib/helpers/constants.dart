import 'package:flutter/animation.dart';

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

const kBackgroundColor = Color(0xffFFFFFF);
