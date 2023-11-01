import 'package:dartz/dartz.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> readNote(ReadNoteUseCaseParams params);
  Future<Either<Failure, Unit>> createNote(CreateNoteUseCaseParams params);
  Future<Either<Failure, Unit>> updateNote(UpdateNoteUseCaseParams params);
  Future<Either<Failure, Unit>> deleteNote(DeleteNoteUseCaseParams params);
  Future<Either<Failure, List<Note>>> readAllNote(ReadAllNoteUseCaseParams params);
}
