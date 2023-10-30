part of '../note_usecases.dart';

@Injectable()
class DeleteNoteUseCase extends UseCase<Unit, DeleteNoteUseCaseParams> {
  final NoteRepository noteRepository;
  DeleteNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Unit>> call(DeleteNoteUseCaseParams params) {
    return noteRepository.deleteNote(params);
  }
}
