import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/src/data/repositories/user_model_repository_impl.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/utils/user_id.dart';

@Singleton()
class AuthorizationPageControlle with ChangeNotifier {
  final FirebaseModule firebaseModule;
  late final UserModelRepositoryImpl userModelRepositoryImpl;

  AuthorizationPageControlle({
    required this.firebaseModule,
  }) {
    userModelRepositoryImpl = UserModelRepositoryImpl(firebaseModule: firebaseModule);
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseModule.auth.signInAnonymously();

      if (userCredential.user != null) {
        UserId.userId = userCredential.user!.uid;
        userModelRepositoryImpl.createUser(
          CreateUserUseCaseParams(
            userId: UserId.userId,
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
