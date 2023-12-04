import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/domain/entities/entities.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/home_page_controller.dart';
import 'package:notes/src/presentation/controller/note_page_controller.dart';
import 'package:notes/src/presentation/page/note_page.dart';
import 'package:notes/src/presentation/widget/home_page/my_end_drawer.dart';
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
    homePageController.readAllNote();
    homePageController.getUserById();

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
      endDrawer: AnimatedBuilder(
        animation: homePageController,
        builder: (BuildContext context, Widget? child) {
          return MyEndDrawer(
            name: homePageController.user.name,
            email: homePageController.user.name,
            imageUrl: homePageController.user.avatarUrl,
            singOut: homePageController.singOut,
          );
        },
      ),
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.menu_rounded),
              );
            },
          ),
          const SizedBox(
            width: 8.0,
          )
        ],
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
              padding: const EdgeInsets.only(
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
                              noteId: note.id!,
                              isComplete: !note.isComplete,
                            );
                            homePageController.readAllNote();
                          },

                          /// Функция удаления
                          functionDismissed: () {
                            homePageController.deleteNote(noteId: note.id!);
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
