import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/enums/impotant_item_enum.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/update_usecase.dart';

import '../../test_repositories.mocks.dart';

//correct createParams
final CreateParamsNote createParamsNote = CreateParamsNote(
  check: false,
  data: 'data',
  date: DateTime.now(),
  important: Imp.low,
);

// corrrect noteId
const String noteId = '1';

// correct Note
final Note correctNote = Note(
  noteId: noteId,
  check: false,
  data: 'data',
  date: DateTime.now(),
  important: Imp.low,
);

// correct updateParamsNote
final UpdateParamsNote updateParamsNote = UpdateParamsNote(
  noteId: noteId,
  data: 'data is correct',
);

// correct UpdateNote
final Note updateNote = Note(
  noteId: noteId,
  check: false,
  data: 'data is correct',
  date: DateTime.now(),
  important: Imp.low,
);

MockNoteRepository arrangeMockNoteRepository() {
  MockNoteRepository mockNoteRepository = MockNoteRepository();

  //! for createNote
  when(
    mockNoteRepository.createNote(noteParams: createParamsNote),
  ).thenAnswer((_) async => const Right(unit));

  ///////////////////////

  //! for deleteNote
  when(
    mockNoteRepository.deleteNote(noteId: noteId),
  ).thenAnswer((_) async => const Right(unit));

  ///////////////////////

  //! for readNote
  when(
    mockNoteRepository.readNote(noteId: noteId),
  ).thenAnswer((_) async => Right(correctNote));

  ///////////////////////

  //! for updateNote
  when(
    mockNoteRepository.updateNote(updateParamsNote: updateParamsNote),
  ).thenAnswer((_) async => const Right(unit));

  ///////////////////////

  return mockNoteRepository;
}
