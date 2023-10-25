import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/repositories/user_repository.dart';

@Singleton()
class CreateUserUseCase extends UseCase<Unit, CreateParamsUser> {
  final UserRepository userRepository;
  CreateUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(CreateParamsUser params) {
    return userRepository.createUser(createParams: params);
  }
}

class CreateParamsUser {
  final String name;
  final String avatarUrl;

  CreateParamsUser({
    required this.name,
    required this.avatarUrl,
  });
}
