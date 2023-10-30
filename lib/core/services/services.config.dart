// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/core/services/services.dart' as _i10;
import 'package:notes/domain/repositories/note_repository.dart' as _i4;
import 'package:notes/domain/repositories/user_repository.dart' as _i6;
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart' as _i3;
import 'package:notes/domain/usecase/note_usecase/delete_usecase.dart' as _i7;
import 'package:notes/domain/usecase/note_usecase/read_usecase.dart' as _i9;
import 'package:notes/domain/usecase/note_usecase/update_usecase.dart' as _i11;
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart' as _i5;
import 'package:notes/domain/usecase/user_usecase/get_by_id_usecase.dart'
    as _i8;
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt generate({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.CreateNoteUseCase>(
        _i3.CreateNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i5.CreateUserUseCase>(
        _i5.CreateUserUseCase(userRepository: gh<_i6.UserRepository>()));
    gh.singleton<_i7.DeleteNoteUseCase>(
        _i7.DeleteNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i8.GetUserByIdUseCase>(
        _i8.GetUserByIdUseCase(userRepository: gh<_i6.UserRepository>()));
    gh.singleton<_i9.ReadNoteUseCase>(
        _i9.ReadNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.factory<_i10.SharedPref>(() => _i10.SharedPref());
    gh.singleton<_i11.UpdateNoteUseCase>(
        _i11.UpdateNoteUseCase(noteRepository: gh<_i4.NoteRepository>()));
    gh.singleton<_i12.UpdateUserUseCase>(
        _i12.UpdateUserUseCase(userRepository: gh<_i6.UserRepository>()));
    return this;
  }
}
