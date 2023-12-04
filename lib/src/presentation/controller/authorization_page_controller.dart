import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/entities/usecases/auth/sing_in_usecase_params.dart';
import 'package:notes/src/domain/usecase/auth_usecase/sing_in_anonymously_usecase.dart';
import 'package:notes/src/domain/usecase/auth_usecase/sing_in_usecase.dart';
import 'package:notes/src/domain/usecase/user_usecases.dart';
import 'package:notes/src/presentation/page/forbidden_page.dart';

@Singleton()
class AuthorizationPageControlle with ChangeNotifier {
  final SingInUseCase singInUseCase;
  final SingInAnonymouslyUseCase singInAnonymouslyUseCase;
  final CreateUserUseCase createUserUseCase;

  AuthorizationPageControlle({
    required this.singInUseCase,
    required this.singInAnonymouslyUseCase,
    required this.createUserUseCase,
  });

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  Future<void> signInAnonymously() async {
    final Either<Failure, User> serverOrResult = await singInAnonymouslyUseCase.call(unit);

    serverOrResult.fold(
      (failure) {
        return const ForbiddenPage();
      },
      (user) async {
        await createUserUseCase.call(
          CreateUserUseCaseParams(
            userId: user.id!,
            userName: user.name,
            avatarUrl: user.avatarUrl,
          ),
        );

        return user;
      },
    );

    notifyListeners();
  }

  Future<void> singIn() async {
    final Either<Failure, User> serverOrResult = await singInUseCase.call(
      SingInUseCaseParams(
        email: emailTextController.text,
        password: passwordTextController.text,
      ),
    );

    serverOrResult.fold(
      (failure) {
        return const ForbiddenPage();
      },
      (user) async {
        await createUserUseCase.call(
          CreateUserUseCaseParams(
            userId: user.id!,
            userName: user.name,
            avatarUrl: user.avatarUrl,
          ),
        );

        return user;
      },
    );

    notifyListeners();
  }
}
