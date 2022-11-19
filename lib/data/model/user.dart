import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;

  const User({
    required this.id,
    required this.email,
    required this.name,
  });

  static const empty = User(id: '', email: '', name: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  @override
  List<Object?> get props => [id, name, email];
}
