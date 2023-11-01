part of '../usecases.dart';

class ReadAllNoteUseCaseParams extends Equatable {
  final String userId;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId];

  const ReadAllNoteUseCaseParams({
    required this.userId,
  });
}
