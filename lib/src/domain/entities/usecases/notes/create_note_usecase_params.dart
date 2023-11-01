part of '../usecases.dart';

class CreateNoteUseCaseParams extends Equatable {
  final String userId;
  final String? data;
  final bool? isComplete;
  final DateTime? dateBeforComplete;
  final PriorityType? priorityType;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userId];

  const CreateNoteUseCaseParams({
    required this.userId,
    this.data,
    this.isComplete,
    this.dateBeforComplete,
    this.priorityType,
  });
}
