part of '../entities.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String avatarUrl;

  @override
  List<Object?> get props => [id ?? unit];

  const User({
    this.id,
    required this.name,
    required this.avatarUrl,
  });
}
