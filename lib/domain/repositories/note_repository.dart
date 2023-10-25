import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/update_usecase.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> readNote({required String noteId});
  Future<Either<Failure, Unit>> createNote({required CreateParamsNote noteParams});
  Future<Either<Failure, Unit>> updateNote({required UpdateParamsNote updateParamsNote});
  Future<Either<Failure, Unit>> deleteNote({required String noteId});
}
