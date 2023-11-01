import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(GetByIdUseCaseParams params);
  Future<Either<Failure, Unit>> createUser(CreateUserUseCaseParams params);
  Future<Either<Failure, Unit>> updateuser(UpdateUserUseCaseParams params);
}
