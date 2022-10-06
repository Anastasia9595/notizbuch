import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool done;

  const Note({required this.id, required this.title, required this.description, required this.date, this.done = false});

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? done,
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
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'done': done,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date']),
      done: map['done'] as bool,
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
