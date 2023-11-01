part of '../note_usecases.dart';

@Injectable()
class ReadAllNoteUseCase extends UseCase<List<Note>, ReadAllNoteUseCaseParams> {
  final NoteRepository noteRepository;
  ReadAllNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, List<Note>>> call(ReadAllNoteUseCaseParams params) {
    return noteRepository.readAllNote(params);
  }
}
