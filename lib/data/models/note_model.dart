// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'dart:convert';

import 'package:notes/domain/entities/note.dart';
import 'package:notes/utils/impotant_item_enum.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.noteId,
    required super.check,
    required super.data,
    required super.date,
    required super.important,
  });

  NoteModel copyWith({
    String? noteId,
    bool? check,
    String? data,
    DateTime? date,
    Imp? important,
  }) {
    return NoteModel(
      noteId: noteId ?? this.noteId,
      check: check ?? this.check,
      data: data ?? this.data,
      date: date ?? this.date,
      important: important ?? this.important,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'noteId': noteId,
      'check': check,
      'data': data,
      'date': date.millisecondsSinceEpoch,
      'important': important,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    final Imp result; // correct with database
    if (map['attributes']['severity'] == 'hight')
      result = Imp.hight;
    else if (map['attributes']['severity'] == 'low')
      result = Imp.low;
    else if (map['attributes']['severity'] == 'not')
      result = Imp.not;
    else
      result = Imp.not;

    return NoteModel(
      noteId: map['noteId'] as String,
      check: map['check'] as bool,
      data: map['data'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      important: result,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(noteId: $noteId, check: $check, data: $data, date: $date, important: $important)';
  }
}
