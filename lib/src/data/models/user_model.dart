// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:notes/domain/entities/user.dart';
// import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/src/domain/entities/entities.dart';

final class UserModel {
  static User fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      id: doc.id,
      name: data['name'],
      avatarUrl: data['avatarUrl'],
    );
  }
}


// class UserModel extends User {
//   const UserModel({
//     required super.userId,
//     required super.name,
//     required super.avatarUrl,
//   });

//   UserModel copyWith({
//     String? userId,
//     String? name,
//     String? avatarUrl,
//   }) {
//     return UserModel(
//       userId: userId ?? this.userId,
//       name: name ?? this.name,
//       avatarUrl: avatarUrl ?? this.avatarUrl,
//     );
//   }


//   Map<String, dynamic> toFirebase() {
//     return <String, dynamic>{
//       'name': name,
//       'avatarUrl': avatarUrl,
//     };
//   }

//   factory UserModel.fromCreateUserParams(CreateParamsUser createParamsUser) {
//     return UserModel(
//       userId: 'null',
//       name: createParamsUser.name,
//       avatarUrl: createParamsUser.avatarUrl,
//     );
//   }
// }
