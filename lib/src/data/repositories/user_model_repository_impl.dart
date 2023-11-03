import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/src/data/models/user_model.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/failures/user_failures.dart';
import 'package:notes/src/domain/repositories/user_repository.dart';

@Singleton(as: UserRepository)
class UserModelRepositoryImpl implements UserRepository {
  final FirebaseModule firebaseModule;

  const UserModelRepositoryImpl({
    required this.firebaseModule,
  });

  @override
  Future<Either<Failure, Unit>> createUser(CreateUserUseCaseParams params) async {
    try {
      final CollectionReference ref = firebaseModule.firebaseFirestore.collection('users');
      User user = User(
        name: params.userName,
        avatarUrl: params.avatarUrl ?? '',
      );

      return ref.add(UserModel.toFirebase(user)).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(GetByIdUseCaseParams params) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId);

      return await ref.get().then<Either<Failure, User>>((user) {
        return Right(UserModel.fromDocument(user));
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateuser(UpdateUserUseCaseParams params) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId);
      User? user;

      ref.get().then((userFireBase) {
        user = UserModel.fromDocument(userFireBase);
      });

      if (user != null) {
        User updateUser = User(
          name: params.userName ?? user!.name,
          avatarUrl: params.avaterUrl ?? user!.avatarUrl,
        );

        await ref.set(UserModel.toFirebase(updateUser));
        return const Right(unit);
      } else {
        return const Left(FirebaseUserInternalFailure());
      }
    } catch (e) {
      return const Left(ExternalUserFailure());
    }
  }
}

// @Singleton(as: UserRepository)
// class UserModelRepositoryImpl implements UserRepository {
//   final FirebaseFirestore firebaseFirestore;

//   UserModelRepositoryImpl({required this.firebaseFirestore});

//   @override
//   Future<Either<Failure, Unit>> createUser({required CreateParamsUser createParams}) async {
//     try {
//       final CollectionReference userCollection = firebaseFirestore.collection('users');
//       final UserModel userModel = UserModel.fromCreateUserParams(createParams);

//       return userCollection.add(userModel.toFirebase()).then<Either<Failure, Unit>>((_) {
//         return const Right(unit);
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseUserInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalUserFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, User>> getUserById({required String userId}) async {
//     try {
//       final DocumentReference userDocument = firebaseFirestore.collection('users').doc(userId);

//       return userDocument.get().then<Either<Failure, User>>((value) {
//         return Right(UserModel.fromDocument(value));
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseUserInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalUserFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateuser({required UpdateParamsUser updateParams}) async {
//     try {
//       Map<String, dynamic> updateData = {};
//       if (updateParams.avatarUrl != null) updateData['avatarUrl'] = updateParams.avatarUrl;
//       if (updateParams.name != null) updateData['name'] = updateParams.name;

//       final DocumentReference userDocument = firebaseFirestore.collection('users').doc(updateParams.userId);
//       return userDocument.update(updateData).then<Either<Failure, Unit>>((_) {
//         return const Right(unit);
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseUserInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalUserFailure());
//     }
//   }
// }
