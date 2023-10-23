// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/utils/impotant_item_enum.dart';

@Injectable()
class UpdateNoteUseCase extends UseCase<Note, UpdateParamsNote> {
  final NoteRepository noteRepository;
  UpdateNoteUseCase({required this.noteRepository});

  @override
  Future<Either<Failure, Note>> call(UpdateParamsNote params) {
    return noteRepository.updateNote(updateParamsNote: params);
  }
}

class UpdateParamsNote {
  final bool check;
  final String data;
  final DateTime date;
  final Imp important;

  UpdateParamsNote(
    this.check,
    this.data,
    this.date,
    this.important,
  );
}
