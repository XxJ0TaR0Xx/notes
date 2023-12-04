import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/usecases/auth/sing_in_usecase_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> singIn(SingInUseCaseParams params);
  Future<Either<Failure, User>> singInAnonymously();
  Future<Either<Failure, Unit>> singOut();
}
