import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/repositories/note_repository.dart';

@Injectable()
class DeleteNoteUseCase extends UseCase<Unit, String> {
  final NoteRepository noteRepository;
  DeleteNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return noteRepository.deleteNote(noteId: params);
  }
}
