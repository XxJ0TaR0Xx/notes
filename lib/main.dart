import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/data/repositories/user_model_repository_impl.dart';
import 'package:notes/datasourse/user_datasourse.dart';
import 'package:notes/domain/entities/user.dart';
import 'package:notes/presentation/app.dart';

Future<void> main() async {
  initServices();
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ru_RU', null);

  //runApp(const App());

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModelRepositoryImpl userModelRepositoryImpl = UserModelRepositoryImpl(firebaseFirestore: firebaseFirestore);

  Either<Failure, User> ans = await userModelRepositoryImpl.getUserById(userId: 'fglGLyHQ2KqF4lZof2sJ');

  print('user: $ans');
}
