import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/repositories/user_repository.dart';

@Singleton(as: UserRepository)
class UserModelRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, Unit>> createUser(CreateUserUseCaseParams params) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUserById(GetByIdUseCaseParams params) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateuser(UpdateUserUseCaseParams params) {
    // TODO: implement updateuser
    throw UnimplementedError();
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
