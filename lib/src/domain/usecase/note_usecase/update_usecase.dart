part of '../note_usecases.dart';

@Singleton()
class UpdateNoteUseCase extends UseCase<Unit, UpdateNoteUseCaseParams> {
  final NoteRepository noteRepository;
  UpdateNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Unit>> call(UpdateNoteUseCaseParams params) {
    return noteRepository.updateNote(params);
  }
}
