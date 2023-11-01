import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/data/repositories/note_model_repository_impl.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/repositories/note_repository.dart';
import 'package:notes/src/domain/usecase/note_usecases.dart';
import 'package:uuid/uuid.dart';

import '../core/firebase/firebase_test_module.dart';

class NoteRepositoryTest {
  static const String debugUserId = 'DEBUG_USER';
  static const String debugNoteId = 'DEBUG_NOTE';

  Future<Either<Failure, Unit>> createUseCaseTest(String data) async {
    final CreateNoteUseCase createNoteUseCase = services<CreateNoteUseCase>();
    CreateNoteUseCaseParams params = CreateNoteUseCaseParams(
      userId: debugUserId,
      data: data,
    );

    return createNoteUseCase.call(params);
  }

  Future<Either<Failure, Unit>> deleteUseCaseTest() async {
    final DeleteNoteUseCase deleteNoteUseCase = services<DeleteNoteUseCase>();
    const DeleteNoteUseCaseParams params = DeleteNoteUseCaseParams(
      userId: debugUserId,
      noteId: debugNoteId,
    );

    return deleteNoteUseCase.call(params);
  }

  Future<Either<Failure, List<Note>>> readAllUseCaseTest() async {
    final ReadAllNoteUseCase readAllUseCase = services<ReadAllNoteUseCase>();
    const ReadAllNoteUseCaseParams params = ReadAllNoteUseCaseParams(
      userId: debugUserId,
    );

    return readAllUseCase.call(params);
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await initServices();
  await services<FirebaseModule>().initTest();

  final NoteRepositoryTest noteRepositoryTest = NoteRepositoryTest();

  group('NoteRepositories', () {
    services.unregister<NoteRepository>();

    test('NoteModelRepositoryImpl', () async {
      services.registerSingleton<NoteRepository>(NoteModelRepositoryImpl(
        firebaseModule: services<FirebaseModule>(),
      ));

      /**
       * CreateNoteUseCase Test
       */

      final String debugUuid = const Uuid().v4();
      Future<Either<Failure, Unit>> createT1Reposnse() => noteRepositoryTest.createUseCaseTest(debugUuid);
      expect(await createT1Reposnse(), isA<Right>(), reason: 'Unexpected CreateNoteUseCase Failure');
      //***

      /**
       * ReadAllNoteUseCase Test
       */

      //***
    });
  });
}
