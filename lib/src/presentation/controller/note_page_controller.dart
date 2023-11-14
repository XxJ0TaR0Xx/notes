import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/core/failure/failure.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/data/repositories/note_model_repository_impl.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/repositories/note_repository.dart';
import 'package:notes/src/domain/usecase/note_usecases.dart';
import 'package:notes/src/domain/utils/date_parser.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/page/forbidden_page.dart';
import 'package:table_calendar/table_calendar.dart';

@Singleton()
class NotePageController with ChangeNotifier {
  late final NoteRepository noteRepository;
  late final CreateNoteUseCase createNoteUseCase;

  NotePageController() {
    noteRepository = NoteModelRepositoryImpl(firebaseModule: services<FirebaseModule>());
    createNoteUseCase = CreateNoteUseCase(noteRepository: noteRepository);
  }

  bool? _switchTurn;
  bool get switchTurn => _switchTurn ?? false;

  String? _dateBeforCompleteStr;
  String get dateBeforCompleteStr => _dateBeforCompleteStr ?? '';

  DateTime? _dateBeforComplete;
  DateTime? get dateBeforComplete => _dateBeforComplete ?? DateTime.now();

  PriorityType? _priorityType;
  PriorityType get priorityType => _priorityType ?? PriorityType.not;

  String? _priorityTypeText;
  String get priorityTypeText => _priorityTypeText ?? 'Нет';

  /// Изменение положения switch
  void turnSwitch() {
    if (switchTurn) {
      _switchTurn = !switchTurn;
      _dateBeforCompleteStr = null;
    } else {
      _switchTurn = !switchTurn;
      _dateBeforCompleteStr = 'Выберите дату';
    }

    notifyListeners();
  }

  /// Функция для проверки даты и switch
  bool checkDateBeforeComplete() {
    if (switchTurn && _dateBeforComplete == null) {
      return false;
    } else {
      return true;
    }
  }

  /// Функция для создания заметки и обработки исключений
  createNote({required context, required CreateNoteUseCaseParams createNoteUseCaseParams}) async {
    if (createNoteUseCaseParams.data != '' && checkDateBeforeComplete()) {
      createNoteController(
        createNoteUseCaseParams: createNoteUseCaseParams,
      );
      Navigator.of(context).pop();
    } else if (createNoteUseCaseParams.data == '') {
      snackBar(
        context: context,
        description: 'Введите текст для заметки',
      );
    } else {
      snackBar(
        context: context,
        description: 'Выберите дату для заметки',
      );
    }
  }

  /// Функция для Вывода SnackBar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
    required dynamic context,
    required String description,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
      ),
    );
  }

  /// Функция открытия и взаимодействия с календарём
  void opencalendar(BuildContext context) async {
    //TODO: Костыль
    DateTime? selectedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 400,
            width: double.infinity,
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20),
              focusedDay: DateTime.now(),
              headerVisible: true,
              daysOfWeekVisible: true,
              sixWeekMonthsEnforced: true,
              shouldFillViewport: false,
              headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.w800)),
              calendarStyle: const CalendarStyle(todayTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              onDaySelected: (selectedDay, focusedDay) {
                Navigator.of(context).pop(selectedDay);
              },
            ),
          ),
        );
      },
    );

    /// Форматируйте выбранную дату
    if (selectedDate != null) {
      _dateBeforCompleteStr = formatDate(selectedDate);
      //!
      _dateBeforComplete = selectedDate;
    }

    notifyListeners();
  }

  void popUpMenuChangeText({required String text}) {
    _priorityTypeText = text;

    notifyListeners();
  }

  void popUpMenuChangePriority({required PriorityType priorityType}) {
    _priorityType = priorityType;

    notifyListeners();
  }

  TextStyle stylePioryty() {
    if (_priorityTypeText == 'Высокая') {
      return TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.colorRed,
      );
    } else {
      return TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.lablTertiaryColor,
      );
    }
  }

  Future<void> createNoteController({required CreateNoteUseCaseParams createNoteUseCaseParams}) async {
    final Either<Failure, Unit> serverOrResult = await createNoteUseCase.call(createNoteUseCaseParams);

    serverOrResult.fold(
      (failure) {
        log("Failure $failure");
        return const ForbiddenPage();
      },
      (unit) {
        log("All is Okey");
      },
    );
    _switchTurn = null;
    _dateBeforCompleteStr = null;
    _dateBeforComplete = null;
    _priorityType = null;
    _priorityTypeText = null;

    notifyListeners();
  }
}
