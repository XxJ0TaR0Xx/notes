import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/src/data/models/note_model.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/failures/note_failures.dart';
import 'package:notes/src/domain/repositories/note_repository.dart';

@Singleton(as: NoteRepository)
class NoteModelRepositoryImpl implements NoteRepository {
  final FirebaseModule firebaseModule;

  const NoteModelRepositoryImpl({
    required this.firebaseModule,
  });

  @override
  Future<Either<Failure, Unit>> createNote(CreateNoteUseCaseParams params) async {
    try {
      final CollectionReference ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId).collection('notes');
      final Note note = Note(
        data: params.data ?? '',
        isComplete: params.isComplete ?? false,
        priorityType: params.priorityType ?? PriorityType.not,
        dateBeforComplete: params.dateBeforComplete,
      );

      return await ref.add(NoteModel.toMap(note)).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(DeleteNoteUseCaseParams params) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Note>> readNote(ReadNoteUseCaseParams params) {
    // TODO: implement readNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateNote(UpdateNoteUseCaseParams params) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Note>>> readAllNote(ReadAllNoteUseCaseParams params) {
    // TODO: implement readAllNote
    throw UnimplementedError();
  }
}

// @Singleton(as: NoteRepository)
// class NoteModelRepositoryImpl implements NoteRepository {
//   final UserDatasourse userDatasourse;
//   final FirebaseFirestore firebaseFirestore;

//   NoteModelRepositoryImpl({
//     required this.firebaseFirestore,
//     required this.userDatasourse,
//   });

//   @override
//   Future<Either<Failure, Unit>> createNote({required CreateParamsNote noteParams}) async {
//     try {
//       final String? userId = await userDatasourse.getUserId();
//       if (userId == null) {
//         return const Left(UserNotExistFailure());
//       }

//       final CollectionReference userNotesCollection = firebaseFirestore.collection('users').doc(userId).collection('notes');
//       final NoteModel noteModel = NoteModel.fromCreateNoteParams(noteParams);

//       return await userNotesCollection.add(noteModel.toFirebase()).then<Either<Failure, Unit>>((_) {
//         return const Right(unit);
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> deleteNote({required String noteId}) async {
//     try {
//       final String? userId = await userDatasourse.getUserId();
//       if (userId == null) {
//         return const Left(UserNotExistFailure());
//       }

//       final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(noteId);
//       return await userNoteDocument.delete().then<Either<Failure, Unit>>((_) {
//         return const Right(unit);
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Note>> readNote({required String noteId}) async {
//     try {
//       final String? userId = await userDatasourse.getUserId();
//       if (userId == null) {
//         return const Left(UserNotExistFailure());
//       }

//       final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(noteId);
//       return await userNoteDocument.get().then<Either<Failure, Note>>((value) {
//         return Right(NoteModel.fromDocument(value));
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateNote({required UpdateParamsNote updateParamsNote}) async {
//     try {
//       final String? userId = await userDatasourse.getUserId();
//       if (userId == null) {
//         return const Left(UserNotExistFailure());
//       }
//       // оптимальный кринж
//       Map<String, dynamic> updateData = {};
//       if (updateParamsNote.data != null) updateData['data'] = updateParamsNote.data;
//       if (updateParamsNote.date != null) updateData['date'] = updateParamsNote.date;
//       if (updateParamsNote.important != null) updateData['important'] = updateParamsNote.important;
//       if (updateParamsNote.check != null) updateData['check'] = updateParamsNote.check;

//       final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(updateParamsNote.noteId);
//       return await userNoteDocument.update(updateData).then<Either<Failure, Unit>>((value) {
//         return const Right(unit);
//       }).onError((error, stackTrace) {
//         return const Left(FirebaseInternalFailure());
//       });
//     } catch (_) {
//       return const Left(ExternalFailure());
//     }
//   }
// }
