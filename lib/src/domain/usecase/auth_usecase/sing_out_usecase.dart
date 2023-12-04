import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/src/domain/repositories/auth_repository.dart';

@Singleton()
class SingOutUseCase extends UseCase<Unit, Unit> {
  final AuthRepository authRepository;

  SingOutUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(Unit params) {
    return authRepository.singOut();
  }
}
