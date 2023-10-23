import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/domain/repositories/user_repository.dart';

@Injectable()
class GetUserByIdUseCase extends UseCase<User, String> {
  final UserRepository userRepository;
  GetUserByIdUseCase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(String params) {
    return userRepository.getUserById(userId: params);
  }
}
