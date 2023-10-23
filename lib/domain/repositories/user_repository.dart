import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById({required String userId});
  Future<Either<Failure, User>> createUser({required CreateParamsUser createParams});
  Future<Either<Failure, Unit>> updateuser({required UpdateParamsUser updateParams});
}
