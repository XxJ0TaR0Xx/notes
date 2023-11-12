import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/data/repositories/note_model_repository_impl.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/repositories/note_repository.dart';
import 'package:notes/src/domain/usecase/note_usecases.dart';
import 'package:notes/src/presentation/page/forbidden_page.dart';

@Singleton()
class HomePageController with ChangeNotifier {
  late final NoteRepository noteRepository;
  late final DeleteNoteUseCase deleteNoteUseCase;
  late final ReadAllNoteUseCase readAllNoteUseCase;
  late final UpdateNoteUseCase updateNoteUseCase;
  late final ReadNoteUseCase readNoteUseCase;

  HomePageController() {
    noteRepository = NoteModelRepositoryImpl(firebaseModule: services<FirebaseModule>());
    deleteNoteUseCase = DeleteNoteUseCase(noteRepository: noteRepository);
    readAllNoteUseCase = ReadAllNoteUseCase(noteRepository: noteRepository);
    updateNoteUseCase = UpdateNoteUseCase(noteRepository: noteRepository);
    readNoteUseCase = ReadNoteUseCase(noteRepository: noteRepository);
  }

  List<Note>? _noteList;
  List<Note> get noteList => _noteList ?? [const Note(data: "Loading", isComplete: false, priorityType: PriorityType.not)];

  List<Note> notCompleteNoteList = [];
  List<Note> noteListBuffer = [];

  Note? _note;
  Note get note => _note ?? const Note(data: "Loading", isComplete: false, priorityType: PriorityType.not);

  String _pathIcon = 'assets/icons/visibility.svg';
  String get pathIcon => _pathIcon;

  int _doneNote = 0;
  int get doneNote => _doneNote;

  countDone(List<Note> allNotes) {
    int i = 0;
    List<Note> buffNotCompleteNoteList = [];

    for (var element in allNotes) {
      if (element.isComplete) {
        i++;
      } else {
        buffNotCompleteNoteList.add(element);
      }
    }
    notCompleteNoteList = buffNotCompleteNoteList;
    _doneNote = i;
  }

  Future<void> readAllNote({required ReadAllNoteUseCaseParams readAllNoteUseCaseParams}) async {
    final Either<Failure, List<Note>> serverResultOrError = await readAllNoteUseCase.call(readAllNoteUseCaseParams);

    serverResultOrError.fold(
      (failure) {
        return const ForbiddenPage();
      },
      (allNotes) {
        countDone(allNotes);
        return _noteList = allNotes;
      },
    );

    notifyListeners();
  }

  Future<void> deleteNote({required DeleteNoteUseCaseParams deleteNoteUseCaseParams}) async {
    final Either<Failure, Unit> serverOrResult = await deleteNoteUseCase.call(deleteNoteUseCaseParams);

    serverOrResult.fold(
      (failure) {
        return const ForbiddenPage();
      },
      (deleteNote) {},
    );

    notifyListeners();
  }

  Future<void> updateIsComplete({required UpdateNoteUseCaseParams updateNoteUseCaseParams}) async {
    final Either<Failure, Unit> serverOrResult = await updateNoteUseCase.call(updateNoteUseCaseParams);

    serverOrResult.fold(
      (failure) {
        log("Failure $failure");
        return const ForbiddenPage();
      },
      (update) {
        log("Update $update");
      },
    );

    notifyListeners();
  }

  Future<void> readNote({required ReadNoteUseCaseParams readNoteUseCaseParams}) async {
    final Either<Failure, Note> serverOrResult = await readNoteUseCase.call(readNoteUseCaseParams);

    serverOrResult.fold(
      (failure) {
        log("Failure $failure");
        return const ForbiddenPage();
      },
      (note) {
        return _note = note;
      },
    );
    notifyListeners();
  }

  void showDoneNote() {
    if (_pathIcon == 'assets/icons/visibility.svg') {
      _pathIcon = 'assets/icons/visibility_off.svg';
    } else {
      _pathIcon = 'assets/icons/visibility.svg';
    }

    log('noteListBuffer $noteListBuffer');

    if (notCompleteNoteList.isNotEmpty && (_noteList != notCompleteNoteList) && _noteList != null) {
      noteListBuffer = _noteList!;
      _noteList = notCompleteNoteList;
    } else {
      _noteList = noteListBuffer;
    }

    notifyListeners();
  }
}
