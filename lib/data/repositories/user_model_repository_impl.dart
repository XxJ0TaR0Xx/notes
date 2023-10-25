import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/data/models/user_model.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/domain/failures/user_failures.dart';
import 'package:notes/domain/repositories/user_repository.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart';

class UserModelRepositoryImpl implements UserRepository {
  final FirebaseFirestore firebaseFirestore;

  UserModelRepositoryImpl({required this.firebaseFirestore});

  @override
  Future<Either<Failure, Unit>> createUser({required CreateParamsUser createParams}) async {
    try {
      final CollectionReference userCollection = firebaseFirestore.collection('users');
      final UserModel userModel = UserModel.fromCreateUserParams(createParams);

      return userCollection.add(userModel.toFirebase()).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    try {
      final DocumentReference userDocument = firebaseFirestore.collection('users').doc(userId);

      return userDocument.get().then<Either<Failure, User>>((value) {
        return Right(UserModel.fromDocument(value));
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateuser({required UpdateParamsUser updateParams}) async {
    try {
      Map<String, dynamic> updateData = {};
      if (updateParams.avatarUrl != null) updateData['avatarUrl'] = updateParams.avatarUrl;
      if (updateParams.name != null) updateData['name'] = updateParams.name;

      final DocumentReference userDocument = firebaseFirestore.collection('users').doc(updateParams.userId);
      return userDocument.update(updateData).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }
}
