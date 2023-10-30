part of '../user_usecases.dart';

@Singleton()
class GetUserByIdUseCase extends UseCase<User, GetByIdUseCaseParams> {
  final UserRepository userRepository;
  GetUserByIdUseCase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(GetByIdUseCaseParams params) {
    return userRepository.getUserById(params);
  }
}
