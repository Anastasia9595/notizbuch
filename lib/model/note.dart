import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Note extends Equatable {
  final int id;
  final Delta title;
  final Delta description;
  final DateTime date;
  final bool done;

  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.done,
  });

  Note copyWith({
    int? id,
    Delta? title,
    Delta? description,
    DateTime? date,
    bool? done,
    bool? isChanged,
  }) {
    return Note(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      done: done ?? this.done,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title.toJson(),
      'description': description.toJson(),
      'date': date.toIso8601String(),
      'done': done,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: Delta.fromJson(map['title']),
      description: Delta.fromJson(map['description']),
      date: DateTime.parse(map['date']),
      done: map['done'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        done,
      ];
}
