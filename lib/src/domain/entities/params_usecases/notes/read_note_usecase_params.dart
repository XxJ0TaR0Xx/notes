part of '../usecases.dart';

class ReadNoteUseCaseParams extends Equatable {
  final String userId;
  final String noteId;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId, noteId];

  const ReadNoteUseCaseParams({
    required this.userId,
    required this.noteId,
  });
}
