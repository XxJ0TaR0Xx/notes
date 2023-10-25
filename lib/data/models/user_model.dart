import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';

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

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      userId: doc.id,
      name: data['name'],
      avatarUrl: data['avatarUrl'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return <String, dynamic>{
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromCreateUserParams(CreateParamsUser createParamsUser) {
    return UserModel(
      userId: 'null',
      name: createParamsUser.name,
      avatarUrl: createParamsUser.avatarUrl,
    );
  }
}
