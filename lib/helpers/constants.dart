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
