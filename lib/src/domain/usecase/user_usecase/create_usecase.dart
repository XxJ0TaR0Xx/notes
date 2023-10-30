part of '../user_usecases.dart';

@Singleton()
class CreateUserUseCase extends UseCase<Unit, CreateUserUseCaseParams> {
  final UserRepository userRepository;
  CreateUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(CreateUserUseCaseParams params) {
    return userRepository.createUser(params);
  }
}
