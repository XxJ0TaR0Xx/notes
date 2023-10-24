import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String avatarUrl;

  @override
  List<Object?> get props => [userId];

  const User({
    required this.userId,
    required this.name,
    required this.avatarUrl,
  });
}
