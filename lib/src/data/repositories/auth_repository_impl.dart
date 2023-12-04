import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/usecases/auth/sing_in_usecase_params.dart';
import 'package:notes/src/domain/failures/auth_failures.dart';
import 'package:notes/src/domain/repositories/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseModule firebaseModul;

  AuthRepositoryImpl({
    required this.firebaseModul,
  });

  @override
  Future<Either<Failure, User>> singIn(SingInUseCaseParams params) async {
    try {
      auth.UserCredential userCredential = await firebaseModul.auth.signInWithEmailAndPassword(
        email: params.email.trim(),
        password: params.password.trim(),
      );

      return Right(
        User(
          id: userCredential.user!.uid,
          name: params.email,
          avatarUrl: 'https://robohash.org/fc521fede990c65811e072336fd64f1f?set=set4&bgset=&size=400x400',
        ),
      );
    } catch (_) {
      return const Left(FirebaseSingInFailure());
    }
  }

  @override
  Future<Either<Failure, User>> singInAnonymously() async {
    try {
      auth.UserCredential userCredential = await firebaseModul.auth.signInAnonymously();

      return Right(
        User(
          id: userCredential.user!.uid,
          name: 'unknow',
          avatarUrl: '',
        ),
      );
    } catch (_) {
      return const Left(FirebaseSingInAnonymouslyFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> singOut() async {
    try {
      await firebaseModul.auth.signOut();

      return const Right(unit);
    } catch (_) {
      return const Left(FirebaseSingInAnonymouslyFailure());
    }
  }
}
