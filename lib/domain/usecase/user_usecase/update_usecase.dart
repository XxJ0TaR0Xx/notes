import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/repositories/user_repository.dart';

@Singleton()
class UpdateUserUseCase extends UseCase<Unit, UpdateParamsUser> {
  final UserRepository userRepository;
  UpdateUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(UpdateParamsUser params) {
    return userRepository.updateuser(updateParams: params);
  }
}

class UpdateParamsUser {
  final String name;
  final String avatarUrl;

  UpdateParamsUser(
    this.name,
    this.avatarUrl,
  );
}
