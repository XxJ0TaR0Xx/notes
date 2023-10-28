import 'package:flutter_test/flutter_test.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:notes/domain/enums/impotant_item_enum.dart';
import 'package:notes/domain/usecase/note_usecase/create_usecase.dart';

void main() {
  final NoteModel originalNote = NoteModel(
    noteId: '1',
    check: true,
    data: 'data',
    date: DateTime(2002, 02, 01),
    important: Imp.hight,
  );

  group('note_model_test', () {
    test('copyWith method', () {
      // Act
      final NoteModel updatedNote = NoteModel(
        noteId: '1',
        check: false,
        data: 'sosiska',
        date: DateTime(2002, 02, 01),
        important: Imp.not,
      );

      // Arrange
      final NoteModel result = originalNote.copyWith(
        check: false,
        data: 'sosiska',
        important: Imp.not,
      );

      // Accert.
      expect(result, updatedNote);
    });

    // test('factory fromDocument', () {
    //   // Act
    //   final data = {
    //     'check': true,
    //     'data': 'Sample Data',
    //     'date': Timestamp.fromDate(DateTime(2023, 10, 28)), // Пример даты как Timestamp
    //     'important': Imp.low.toString(),
    //   };

    //   // Создаем объект DocumentSnapshot с имитацией данных
    //   final documentSnapshot = DocumentSnapshot(
    //     data: data,
    //     documentID: '2',
    //   );
    //   // Arrange
    //   final NoteModel result = NoteModel.fromDocument(documentSnapshot);

    //   // Accert
    //   expect(result, originalNote);
    // });

    test('method toFirebase', () {
      // Act
      final Map<String, dynamic> resultNote = {
        'check': true,
        'data': 'data',
        'date': DateTime(2002, 02, 01),
        'important': 'hight',
      };
      // Arrange
      final Map<String, dynamic> result = originalNote.toFirebase();

      // Accert
      expect(result, resultNote);
    });

    test('factory fromCreateNoteParams', () {
      // Act
      final CreateParamsNote createParamsNote = CreateParamsNote(
        check: true,
        data: 'data',
        date: DateTime(2002, 02, 01),
        important: Imp.hight,
      );

      // Arrange
      final NoteModel result = NoteModel.fromCreateNoteParams(createParamsNote);

      // Accert
      expect(result.check, originalNote.check);
      expect(result.data, originalNote.data);
      expect(result.date, originalNote.date);
      expect(result.important, originalNote.important);
    });
  });
}
