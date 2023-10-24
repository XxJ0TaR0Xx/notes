import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/repositories/note_repository.dart';

@Singleton()
class ReadNoteUseCase extends UseCase<Note, String> {
  final NoteRepository noteRepository;
  ReadNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Note>> call(String params) {
    return noteRepository.readNote(noteId: params);
  }
}
