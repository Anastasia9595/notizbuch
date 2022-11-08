import 'package:flutter_quill/flutter_quill.dart';

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
