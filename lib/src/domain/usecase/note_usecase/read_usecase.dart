part of '../note_usecases.dart';

@Injectable()
class ReadNoteUseCase extends UseCase<Note, ReadNoteUseCaseParams> {
  final NoteRepository noteRepository;
  ReadNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Note>> call(ReadNoteUseCaseParams params) {
    return noteRepository.readNote(params);
  }
}
