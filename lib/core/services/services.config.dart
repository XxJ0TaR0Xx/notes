// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/core/firebase/firebase_module.dart' as _i3;
import 'package:notes/src/data/datasourse/user_datasourse.dart' as _i7;
import 'package:notes/src/data/repositories/note_model_repository_impl.dart'
    as _i5;
import 'package:notes/src/data/repositories/user_model_repository_impl.dart'
    as _i9;
import 'package:notes/src/domain/repositories/note_repository.dart' as _i4;
import 'package:notes/src/domain/repositories/user_repository.dart' as _i8;
import 'package:notes/src/domain/usecase/note_usecases.dart' as _i6;
import 'package:notes/src/domain/usecase/user_usecases.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.FirebaseModule>(_i3.FirebaseModule());
    gh.singleton<_i4.NoteRepository>(
        _i5.NoteModelRepositoryImpl(firebaseModule: gh<_i3.FirebaseModule>()));
    gh.factory<_i6.ReadAllNoteUseCase>(
        () => _i6.ReadAllNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.factory<_i6.ReadNoteUseCase>(
        () => _i6.ReadNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i6.UpdateNoteUseCase>(
        _i6.UpdateNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i7.UserDatasourse>(_i7.UserDatasourse());
    gh.singleton<_i8.UserRepository>(_i9.UserModelRepositoryImpl());
    gh.factory<_i6.CreateNoteUseCase>(
        () => _i6.CreateNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i10.CreateUserUseCase>(
        _i10.CreateUserUseCase(userRepository: gh<_i8.UserRepository>()));
    gh.factory<_i6.DeleteNoteUseCase>(
        () => _i6.DeleteNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i10.GetUserByIdUseCase>(
        _i10.GetUserByIdUseCase(userRepository: gh<_i8.UserRepository>()));
    gh.singleton<_i10.UpdateUserUseCase>(
        _i10.UpdateUserUseCase(userRepository: gh<_i8.UserRepository>()));
    return this;
  }
}
