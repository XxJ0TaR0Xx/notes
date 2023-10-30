part of '../usecases.dart';

class DeleteNoteUseCaseParams extends Equatable {
  final String userId;
  final String noteId;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId, noteId];

  const DeleteNoteUseCaseParams({
    required this.userId,
    required this.noteId,
  });
}
