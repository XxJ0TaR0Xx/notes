import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/data/repositories/user_model_repository_impl.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/repositories/user_repository.dart';
import 'package:notes/src/domain/usecase/user_usecases.dart';

import '../core/firebase/firebase_test_module.dart';

class UserRepositoryTest {
  static const String debugUserId = 'DEBUG_USER';

  Future<Either<Failure, Unit>> createUserUseCase(String uName, String uAvatar) async {
    final CreateUserUseCase createUserUseCase = services<CreateUserUseCase>();
    CreateUserUseCaseParams params = CreateUserUseCaseParams(
      userId: debugUserId,
      userName: uName,
      avatarUrl: uAvatar,
    );

    return createUserUseCase.call(params);
  }

  Future<Either<Failure, User>> getUserByIdUseCase() async {
    final GetUserByIdUseCase getUserByIdUseCase = services<GetUserByIdUseCase>();
    GetByIdUseCaseParams params = const GetByIdUseCaseParams(userId: debugUserId);

    return getUserByIdUseCase.call(params);
  }

  Future<Either<Failure, Unit>> updateUserUseCase(String newUserName, String newAvatar) {
    final UpdateUserUseCase updateUserUseCase = services<UpdateUserUseCase>();
    UpdateUserUseCaseParams params = UpdateUserUseCaseParams(
      userId: debugUserId,
      userName: newUserName,
      avaterUrl: newAvatar,
    );

    return updateUserUseCase.call(params);
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await initServices();
  await services<FirebaseModule>().initTest();

  final UserRepositoryTest userRepositoryTest = UserRepositoryTest();

  group('UserRepository', () {
    services.unregister<UserRepository>();

    test('UserModelRepositoryImpl', () async {
      services.registerSingleton<UserRepository>(UserModelRepositoryImpl(
        firebaseModule: services<FirebaseModule>(),
      ));

      //CreateUserUseCase Test
      Future<Either<Failure, Unit>> createUserUseCase() => userRepositoryTest.createUserUseCase(
            'User',
            'Avatar',
          );
      expect(
        await createUserUseCase(),
        isA<Right>(),
        reason: 'Unexpected CreateUserUseCase Failure',
      );

      //////////////////////////

      //GetUserByIdUseCase Test
      Future<Either<Failure, User>> getUser() => userRepositoryTest.getUserByIdUseCase();
      expect(
        await getUser(),
        const Right(User(name: 'User', avatarUrl: 'Avatar')),
        reason: 'Unexpected GetUserByIdUseCase Failure',
      );

      //////////////////////////

      //UpdateUserUseCase Test
      Future<Either<Failure, Unit>> updateUser() => userRepositoryTest.updateUserUseCase('UserNameTest', 'NewAvatar');
      expect(
        await updateUser(),
        isA<Right>(),
        reason: 'Unexpected UpdateUserUseCase Failure',
      );

      Future<Either<Failure, User>> getCorrectUser() => userRepositoryTest.getUserByIdUseCase();
      expect(
        await getCorrectUser(),
        const Right(User(name: 'UserNameTest', avatarUrl: 'NewAvatar')),
        reason: 'Update dost\'t work correct',
      );
    });
  });
}
