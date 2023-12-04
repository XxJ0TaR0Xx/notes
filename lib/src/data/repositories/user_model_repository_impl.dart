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
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId);
      User user = User(
        name: params.userName,
        avatarUrl: params.avatarUrl ?? '',
      );

      return ref.set(UserModel.toFirebase(user)).then<Either<Failure, Unit>>((_) {
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

      Map<String, dynamic> updateData = {};
      if (params.avaterUrl != null) updateData['avatarUrl'] = params.avaterUrl;
      if (params.userName != null) updateData['name'] = params.userName;

      return await ref.update(updateData).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseUserInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalUserFailure());
    }
  }
}
