// // ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:notes/domain/entities/note.dart';
// import 'package:notes/domain/enums/impotant_item_enum.dart';
// import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';
// import 'package:notes/domain/utils/imp_parse.dart';

// class NoteModel extends Note {
//   const NoteModel({
//     required super.noteId,
//     required super.check,
//     required super.data,
//     required super.date,
//     required super.important,
//   });

//   NoteModel copyWith({
//     String? noteId,
//     bool? check,
//     String? data,
//     DateTime? date,
//     Imp? important,
//   }) {
//     return NoteModel(
//       noteId: noteId ?? this.noteId,
//       check: check ?? this.check,
//       data: data ?? this.data,
//       date: date ?? this.date,
//       important: important ?? this.important,
//     );
//   }

//   factory NoteModel.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     return NoteModel(
//       noteId: doc.id,
//       check: data['check'],
//       data: data['data'],
//       date: (data['date'] as Timestamp).toDate(),
//       important: ImpParse.strToImp(data['important']),
//     );
//   }

//   Map<String, dynamic> toFirebase() {
//     return <String, dynamic>{
//       'check': check,
//       'data': data,
//       'date': date,
//       'important': ImpParse.impToStr(important),
//     };
//   }

//   factory NoteModel.fromCreateNoteParams(CreateParamsNote createParamsNote) {
//     return NoteModel(
//       noteId: 'null',
//       check: createParamsNote.check,
//       data: createParamsNote.data,
//       date: createParamsNote.date,
//       important: createParamsNote.important,
//     );
//   }
// }