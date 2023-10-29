import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/domain/repositories/user_repository.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/delete_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/read_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/update_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/get_by_id_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart';

final GetIt testServices = GetIt.I;

FutureOr<void> initMockTestServices() {
  testServices.registerLazySingleton<NoteRepository>(() => arrangeMockNoteRepository());
  testServices.registerLazySingleton<UserRepository>(() => arrangeMockUserRepository());
}

FutureOr<void> initUsecaseTestServises() {
  //! GROUP NOTE
  //! for Create
  testServices.registerLazySingleton<CreateNoteUseCase>(() => CreateNoteUseCase());

  //! for Update
  testServices.registerLazySingleton<UpdateNoteUseCase>(() => UpdateNoteUseCase());

  //! for Delete
  testServices.registerLazySingleton<DeleteNoteUseCase>(() => DeleteNoteUseCase());

  //! for ReadUsecase
  testServices.registerLazySingleton<ReadNoteUseCase>(() => ReadNoteUseCase());

  ///////////////////////

  //! GROUP USER
  //! for Create
  testServices.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase());

  //! for GetById
  testServices.registerLazySingleton<GetUserByIdUseCase>(() => GetUserByIdUseCase());

  //! for Update
  testServices.registerLazySingleton<UpdateUserUseCase>(() => UpdateUserUseCase());

  ///////////////////////
}
