import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/domain/repositories/user_repository.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart';

class UserModelRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, User>> createUser({required CreateParamsUser createParams}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateuser({required UpdateParamsUser updateParams}) {
    // TODO: implement updateuser
    throw UnimplementedError();
  }
}
