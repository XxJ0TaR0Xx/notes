import 'package:equatable/equatable.dart';
import 'package:notes/utils/impotant_item_enum.dart';

class Note extends Equatable {
  final String noteId;
  final bool check;
  final String data;
  final DateTime date;
  final Imp important;

  @override
  List<Object?> get props => [noteId];

  const Note({
    required this.noteId,
    required this.check,
    required this.data,
    required this.date,
    required this.important,
  });
}
