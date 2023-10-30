part of '../note_usecases.dart';

@Injectable()
class CreateNoteUseCase extends UseCase<Unit, CreateNoteUseCaseParams> {
  final NoteRepository noteRepository;

  CreateNoteUseCase({
    required this.noteRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(CreateNoteUseCaseParams params) {
    return noteRepository.createNote(params);
  }
}
