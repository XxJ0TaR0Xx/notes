import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/usecases/auth/sing_in_usecase_params.dart';
import 'package:notes/src/domain/repositories/auth_repository.dart';

@Injectable()
class SingInUseCase extends UseCase<User, SingInUseCaseParams> {
  final AuthRepository authRepository;

  SingInUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(SingInUseCaseParams params) {
    return authRepository.singIn(params);
  }
}
