// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/usecase/usecase.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/domain/enums/impotant_item_enum.dart';

@Singleton()
class CreateNoteUseCase extends UseCase<Unit, CreateParamsNote> {
  final NoteRepository noteRepository;
  CreateNoteUseCase({required this.noteRepository});
  @override
  Future<Either<Failure, Unit>> call(CreateParamsNote params) {
    return noteRepository.createNote(noteParams: params);
  }
}

class CreateParamsNote {
  final bool check;
  final String data;
  final DateTime date;
  final Imp important;

  CreateParamsNote({
    required this.check,
    required this.data,
    required this.date,
    required this.important,
  });
}
