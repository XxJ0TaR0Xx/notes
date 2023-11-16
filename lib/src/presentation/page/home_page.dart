import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/domain/utils/user_id.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/home_page_controller.dart';
import 'package:notes/src/presentation/controller/note_page_controller.dart';
import 'package:notes/src/presentation/page/note_page.dart';
import 'package:notes/src/presentation/widget/main_page/add_todo_row_widget.dart';
import 'package:notes/src/presentation/widget/main_page/back_container_widget.dart';
import 'package:notes/src/presentation/widget/main_page/container_for_add_row_widget.dart';
import 'package:notes/src/presentation/widget/main_page/fab_widget.dart';
import 'package:notes/src/presentation/widget/main_page/my_tasks_widget.dart';
import 'package:notes/src/presentation/widget/row/dismissable_row_widget.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';
  final HomePageController homePageController;

  const HomePage({
    super.key,
    required this.homePageController,
  });

  @override
  Widget build(BuildContext context) {
    const String userId = 'fglGLyHQ2KqF4lZof2sJ';

    homePageController.readAllNote(
      readAllNoteUseCaseParams: ReadAllNoteUseCaseParams(
        userId: UserId.userId,
      ),
    );

    FutureOr<void> onPressedAddNote() async {
      Navigator.of(context).pushNamed(NotePage.route);
    }

    FutureOr<void> onPressedUpdateNote(
      String updateData,
      PriorityType priorityType,
      DateTime? updateDateBeforComplete,
      String? updateNoteId,
    ) async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotePage(
            notePageController: services<NotePageController>(),
            updateData: updateData,
            updatePriorityType: priorityType,
            updateDateBeforComplete: updateDateBeforComplete,
            updateNoteId: updateNoteId,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 60.0,
              ),
              child: AnimatedBuilder(
                animation: homePageController,
                builder: (BuildContext context, Widget? child) {
                  return MyTasksWidget(
                    onPressed: () => homePageController.showDoneNote(),
                    count: homePageController.doneNote,
                    iconPath: homePageController.pathIcon,
                  );
                },
              ),
            ),
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 16.0,
              ),
              child: BackContainer(
                child: AnimatedBuilder(
                  animation: homePageController,
                  builder: (BuildContext context, Widget? child) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Отключаем скроллинг ListView.builder
                      shrinkWrap: true,
                      itemCount: homePageController.noteList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Note note = homePageController.noteList[index];
                        return DissmisableRowWidget(
                          priorityType: note.priorityType,
                          isComplete: note.isComplete,
                          keyItem: index.toString(),
                          data: note.data,
                          date: homePageController.parsDate(note.dateBeforComplete),

                          /// Функция смены флажка isComplet
                          functionUpdate: () {
                            homePageController.updateIsComplete(
                              updateNoteUseCaseParams: UpdateNoteUseCaseParams(
                                userId: UserId.userId,
                                noteId: note.id!,
                                isComplete: !note.isComplete,
                              ),
                            );
                            homePageController.readAllNote(
                              readAllNoteUseCaseParams: ReadAllNoteUseCaseParams(
                                userId: UserId.userId,
                              ),
                            );
                          },

                          /// Функция удаления
                          functionDismissed: () {
                            homePageController.deleteNote(
                              deleteNoteUseCaseParams: DeleteNoteUseCaseParams(userId: UserId.userId, noteId: note.id!),
                            );
                            homePageController.noteList.removeAt(index);
                            homePageController.notCompleteNoteList.removeAt(index);
                          },

                          /// Функция для обновления заметки
                          toUpdateNote: () {
                            onPressedUpdateNote(
                              note.data,
                              note.priorityType,
                              note.dateBeforComplete,
                              note.id,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            ContainerForRowWidget(
              child: AddToDoRowWidget(
                onPressed: onPressedAddNote,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FabWidget(
        onPressed: onPressedAddNote,
      ),
    );
  }
}
