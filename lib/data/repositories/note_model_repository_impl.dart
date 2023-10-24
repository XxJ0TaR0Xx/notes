import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/updaet_usecase.dart';

class NoteModelRepositoryImpl implements NoteRepository {
  @override
  Future<Either<Failure, Unit>> createNote({required CreateParamsNote noteParams}) {
    // TODO: implement createNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteNote({required String noteId}) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Note>> readNote({required String noteId}) {
    // TODO: implement readNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Note>> updateNote({required UpdateParamsNote updateParamsNote}) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
