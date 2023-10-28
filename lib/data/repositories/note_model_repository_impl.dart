import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:notes/datasourse/user_datasourse.dart';
import 'package:notes/domain/entities/note.dart';
import 'package:notes/domain/failures/note_failures.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/note_usecase/update_usecase.dart';

@Singleton(as: NoteRepository)
class NoteModelRepositoryImpl implements NoteRepository {
  final UserDatasourse userDatasourse;
  final FirebaseFirestore firebaseFirestore;

  NoteModelRepositoryImpl({
    required this.firebaseFirestore,
    required this.userDatasourse,
  });

  @override
  Future<Either<Failure, Unit>> createNote({required CreateParamsNote noteParams}) async {
    try {
      final String? userId = await userDatasourse.getUserId();
      if (userId == null) {
        return const Left(UserNotExistFailure());
      }

      final CollectionReference userNotesCollection = firebaseFirestore.collection('users').doc(userId).collection('notes');
      final NoteModel noteModel = NoteModel.fromCreateNoteParams(noteParams);

      return userNotesCollection.add(noteModel.toFirebase()).then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote({required String noteId}) async {
    try {
      final String? userId = await userDatasourse.getUserId();
      if (userId == null) {
        return const Left(UserNotExistFailure());
      }

      final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(noteId);
      return userNoteDocument.delete().then<Either<Failure, Unit>>((_) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> readNote({required String noteId}) async {
    try {
      final String? userId = await userDatasourse.getUserId();
      if (userId == null) {
        return const Left(UserNotExistFailure());
      }

      final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(noteId);
      return userNoteDocument.get().then<Either<Failure, Note>>((value) {
        return Right(NoteModel.fromDocument(value));
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote({required UpdateParamsNote updateParamsNote}) async {
    try {
      final String? userId = await userDatasourse.getUserId();
      if (userId == null) {
        return const Left(UserNotExistFailure());
      }
      // оптимальный кринж
      Map<String, dynamic> updateData = {};
      if (updateParamsNote.data != null) updateData['data'] = updateParamsNote.data;
      if (updateParamsNote.date != null) updateData['date'] = updateParamsNote.date;
      if (updateParamsNote.important != null) updateData['important'] = updateParamsNote.important;
      if (updateParamsNote.check != null) updateData['check'] = updateParamsNote.check;

      final DocumentReference userNoteDocument = firebaseFirestore.collection('users').doc(userId).collection('notes').doc(updateParamsNote.noteId);
      return userNoteDocument.update(updateData).then<Either<Failure, Unit>>((value) {
        return const Right(unit);
      }).onError((error, stackTrace) {
        return const Left(FirebaseInternalFailure());
      });
    } catch (_) {
      return const Left(ExternalFailure());
    }
  }
}
