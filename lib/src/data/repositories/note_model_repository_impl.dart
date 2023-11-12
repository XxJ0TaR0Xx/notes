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

      return await ref.add(NoteModel.toFirebase(note)).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(DeleteNoteUseCaseParams params) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId).collection('notes').doc(params.noteId);

      return await ref.delete().then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> readNote(ReadNoteUseCaseParams params) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId).collection('notes').doc(params.noteId);

      return await ref.get().then<Either<Failure, Note>>((note) {
        return Right(NoteModel.fromDoc(note));
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(UpdateNoteUseCaseParams params) async {
    try {
      final DocumentReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId).collection('notes').doc(params.noteId);

      Map<String, dynamic> updateData = {};
      if (params.data != null) updateData['data'] = params.data;
      if (params.dateBeforComplete != null) updateData['dateBeforComplete'] = params.dateBeforComplete;
      if (params.priorityType != null) updateData['priority'] = params.priorityType;
      if (params.isComplete != null) updateData['isComplete'] = params.isComplete;

      return await ref.update(updateData).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Note>>> readAllNote(ReadAllNoteUseCaseParams params) async {
    List<Note> listNote = [];
    try {
      final CollectionReference<Map<String, dynamic>> ref = firebaseModule.firebaseFirestore.collection('users').doc(params.userId).collection('notes');
      return await ref.get().then<Either<Failure, List<Note>>>((noteQuerySnapshot) {
        if (noteQuerySnapshot.docs.isEmpty) {
          return Right(listNote);
        } else {
          // ignore: avoid_function_literals_in_foreach_calls
          noteQuerySnapshot.docs.forEach((doc) {
            listNote.add(NoteModel.fromDoc(doc));
          });
          return Right(listNote);
        }
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
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
//   Future<Either<Failure, Unit>> updateNote({required params params}) async {
//     try {
//       final String? userId = await userDatasourse.getUserId();
//       if (userId == null) {
//         return const Left(UserNotExistFailure());
//       }
//       // оптимальный кринж
//       Map<String, dynamic> updateData = {};
//       if (params.data != null) updateData['data'] = params.data;
//       if (params.date != null) updateData['date'] = params.date;
//       if (params.important != null) updateData['important'] = params.important;
//       if (params.check != null) updateData['check'] = params.check;

//       final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(params.noteId);
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
