part of '../entities.dart';

class Note extends Equatable {
  final String? id;
  final String data;
  final bool isComplete;
  final DateTime? dateBeforComplete;
  final PriorityType priorityType;

  @override
  List<Object?> get props => [id ?? unit];

  const Note({
    this.id,
    required this.data,
    required this.isComplete,
    required this.priorityType,
    this.dateBeforComplete,
  });
}
