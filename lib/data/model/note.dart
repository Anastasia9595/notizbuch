import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Note extends Equatable {
  final int id;
  final Delta title;
  final Delta description;
  final DateTime date;
  final bool done;
  final bool isFavorite;

  const Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.done,
      required this.isFavorite});

  Note copyWith({
    int? id,
    Delta? title,
    Delta? description,
    DateTime? date,
    bool? done,
    bool? isChanged,
    bool? isFavorite,
  }) {
    return Note(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      done: done ?? this.done,
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title.toJson(),
      'description': description.toJson(),
      'date': date.toIso8601String(),
      'done': done,
      'isFavorite': isFavorite,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: Delta.fromJson(map['title']),
      description: Delta.fromJson(map['description']),
      date: DateTime.parse(map['date']),
      done: map['done'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        done,
        isFavorite,
      ];
}
