part of '../note_usecases.dart';

@Injectable()
class ReadAllNoteUseCase extends UseCase<List<Note>, ReadNoteUseCaseParams> {
  final NoteRepository noteRepository;
  ReadAllNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, List<Note>>> call(ReadNoteUseCaseParams params) {
    return noteRepository.readAllNote(params);
  }
}
