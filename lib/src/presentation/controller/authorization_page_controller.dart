import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/src/data/datasourse/user_datasourse.dart';
import 'package:notes/src/data/repositories/user_model_repository_impl.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';

@Singleton()
class AuthorizationPageControlle with ChangeNotifier {
  final FirebaseModule firebaseModule;
  final UserDatasourse userDatasourse;
  late final UserModelRepositoryImpl userModelRepositoryImpl;

  AuthorizationPageControlle({
    required this.firebaseModule,
    required this.userDatasourse,
  }) {
    userModelRepositoryImpl = UserModelRepositoryImpl(firebaseModule: firebaseModule);
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseModule.auth.signInAnonymously();
      String? userId = await userDatasourse.getUserId();

      if (userCredential.user != null && userId == null) {
        userDatasourse.saveUserId(userCredential.user!.uid);
        String? updateUserId = await userDatasourse.getUserId();

        userModelRepositoryImpl.createUser(
          CreateUserUseCaseParams(
            userId: updateUserId!,
            userName: 'unknow',
          ),
        );
      }

      log('Авторизация успешна: ${userCredential.user!.uid}');
    } catch (e) {
      log('Ошибка при авторизации: $e');
    }

    notifyListeners();
  }
}
