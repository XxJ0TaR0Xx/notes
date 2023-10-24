// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:notes/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.avatarUrl,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? avatarUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      avatarUrl: map['avatarUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(userId: $userId, name: $name, avatarUrl: $avatarUrl)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.name == name && other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ avatarUrl.hashCode;
}
