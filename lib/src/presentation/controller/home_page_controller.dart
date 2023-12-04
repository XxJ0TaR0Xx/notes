import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/usecase/auth_usecase/sing_out_usecase.dart';
import 'package:notes/src/domain/usecase/note_usecases.dart';
import 'package:notes/src/domain/usecase/user_usecases.dart';
import 'package:notes/src/domain/utils/date_parser.dart';
import 'package:notes/src/presentation/page/forbidden_page.dart';

@Singleton()
class HomePageController with ChangeNotifier {
  final DeleteNoteUseCase deleteNoteUseCase;
  final ReadAllNoteUseCase readAllNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final ReadNoteUseCase readNoteUseCase;
  final SingOutUseCase singOutUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  HomePageController({
    required this.deleteNoteUseCase,
    required this.readAllNoteUseCase,
    required this.updateNoteUseCase,
    required this.readNoteUseCase,
    required this.singOutUseCase,
    required this.getUserByIdUseCase,
  });

  Note noteLoading = const Note(data: "Loading", isComplete: false, priorityType: PriorityType.not);

  User? _user;
  User get user =>
      _user ??
      const User(
        name: 'Loading',
        avatarUrl: 'https://yandex.ru/images/search?text=unknown+user++image&img_url=https%3A%2F%2Fgotrening.com%2Fwp-content%2Fuploads%2F2021%2F04%2Fuser.png&pos=3&rpt=simage&stype=image&lr=118653&parent-reqid=1701624640179637-11832949636910780843-balancer-l7leveler-kubr-yp-vla-153-BAL-4370&source=serp',
      );

  List<Note>? _noteList;
  List<Note> get noteList => _noteList ?? [noteLoading];

  List<Note> notCompleteNoteList = [];
  List<Note> noteListBuffer = [];

  Note? _note;
  Note get note => _note ?? noteLoading;

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

  Future<void> getUserById() async {
    final Either<Failure, User> serverOrResult = await getUserByIdUseCase.call(
      GetByIdUseCaseParams(
        userId: services<FirebaseModule>().auth.currentUser!.uid,
      ),
    );

    serverOrResult.fold(
      (failure) {
        navigateToErrorPage();
      },
      (user) {
        print('User ${user.id} and ${user.avatarUrl}');
        _user = user;
      },
    );
  }

  Future<void> readAllNote() async {
    print('Read all Notes user id:${services<FirebaseModule>().auth.currentUser!.uid}');

    final Either<Failure, List<Note>> serverResultOrError = await readAllNoteUseCase.call(
      ReadAllNoteUseCaseParams(
        userId: services<FirebaseModule>().auth.currentUser!.uid,
      ),
    );

    serverResultOrError.fold(
      (failure) {
        navigateToErrorPage();
      },
      (allNotes) {
        countDone(allNotes);
        return _noteList = allNotes;
      },
    );

    notifyListeners();
  }

  Future<void> singOut() async {
    final Either<Failure, Unit> serverOrResult = await singOutUseCase.call(unit);

    serverOrResult.fold(
      (failure) {
        navigateToErrorPage();
      },
      (unit) {},
    );
  }

  Future<void> deleteNote({required String noteId}) async {
    final Either<Failure, Unit> serverOrResult = await deleteNoteUseCase.call(
      DeleteNoteUseCaseParams(
        userId: services<FirebaseModule>().auth.currentUser!.uid,
        noteId: noteId,
      ),
    );

    serverOrResult.fold(
      (failure) {
        navigateToErrorPage();
      },
      (deleteNote) {},
    );

    notifyListeners();
  }

  Future<void> updateIsComplete({
    required String noteId,
    required bool isComplete,
  }) async {
    final Either<Failure, Unit> serverOrResult = await updateNoteUseCase.call(
      UpdateNoteUseCaseParams(
        userId: services<FirebaseModule>().auth.currentUser!.uid,
        noteId: noteId,
        isComplete: isComplete,
      ),
    );

    serverOrResult.fold(
      (failure) {
        navigateToErrorPage();
      },
      (update) {},
    );

    notifyListeners();
  }

  Future<void> readNote({required String noteId}) async {
    final Either<Failure, Note> serverOrResult = await readNoteUseCase.call(
      ReadNoteUseCaseParams(
        userId: services<FirebaseModule>().auth.currentUser!.uid,
        noteId: noteId,
      ),
    );

    serverOrResult.fold(
      (failure) {
        navigateToErrorPage();
      },
      (note) {
        return _note = note;
      },
    );
    notifyListeners();
  }

  void showDoneNote() {
    String visibilityPath = 'assets/icons/visibility.svg';
    String visibilityOffPath = 'assets/icons/visibility_off.svg';

    if (_pathIcon == visibilityPath) {
      _pathIcon = visibilityOffPath;
    } else {
      _pathIcon = visibilityPath;
    }

    if ((_noteList != notCompleteNoteList) && (_noteList != null)) {
      noteListBuffer = _noteList!;
      _noteList = notCompleteNoteList;
    } else {
      _noteList = noteListBuffer;
    }

    notifyListeners();
  }

  String parsDate(DateTime? dateTime) {
    return formatDate(dateTime);
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void navigateToErrorPage() {
  navigatorKey.currentState?.pushReplacement(
    MaterialPageRoute(
      builder: (context) => const ForbiddenPage(),
    ),
  );
}
