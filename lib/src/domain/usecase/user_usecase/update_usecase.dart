part of '../user_usecases.dart';

@Singleton()
class UpdateUserUseCase extends UseCase<Unit, UpdateUserUseCaseParams> {
  final UserRepository userRepository;

  UpdateUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(UpdateUserUseCaseParams params) {
    return userRepository.updateuser(params);
  }
}
