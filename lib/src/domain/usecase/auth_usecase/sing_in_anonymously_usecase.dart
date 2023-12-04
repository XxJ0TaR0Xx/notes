import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/repositories/auth_repository.dart';

@Injectable()
class SingInAnonymouslyUseCase extends UseCase<User, Unit> {
  final AuthRepository authRepository;

  SingInAnonymouslyUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(Unit params) {
    return authRepository.singInAnonymously();
  }
}
