import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/entities/params_usecases/usecases.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/note_page_controller.dart';

class NotePage extends StatelessWidget {
  static const String route = '/note';
  final NotePageController notePageController;

  NotePage({
    super.key,
    required this.notePageController,
  });
  final TextEditingController textDataController = TextEditingController();
  final String userId = 'fglGLyHQ2KqF4lZof2sJ';

  final String not = 'Нет';
  final String low = 'Низкая';
  final String hight = 'Высокая';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            /// Возвращаемся на предыдущий экран
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/close.svg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AnimatedBuilder(
              animation: notePageController,
              builder: (BuildContext context, Widget? child) {
                return TextButton(
                  onPressed: () {
                    notePageController.createNote(
                      context: context,
                      createNoteUseCaseParams: CreateNoteUseCaseParams(
                        userId: userId,
                        data: textDataController.text,
                        dateBeforComplete: notePageController.dateBeforComplete,
                        isComplete: false,
                        priorityType: notePageController.priorityType,
                      ),
                    );
                  },
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      letterSpacing: 0.16,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backElevatedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),

                    /// Вводт описания для заметки
                    child: TextField(
                      controller: textDataController,
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: const SizedBox(width: 16.0),
                        hintText: 'Что надо сделать...',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lablTertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedBuilder(
                  animation: notePageController,
                  builder: (context, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Важность',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4.0),

                        /// Выплывающее меню для выбора важности заметки
                        PopupMenuButton<PriorityType>(
                          initialValue: notePageController.priorityType,
                          onSelected: (PriorityType priorityType) {
                            notePageController.popUpMenuChangePriority(priorityType: priorityType);
                          },
                          itemBuilder: (context) => <PopupMenuEntry<PriorityType>>[
                            PopupMenuItem<PriorityType>(
                              onTap: () => notePageController.popUpMenuChangeText(text: not),
                              value: PriorityType.not,
                              child: Text(not),
                            ),
                            PopupMenuItem<PriorityType>(
                              onTap: () => notePageController.popUpMenuChangeText(text: low),
                              value: PriorityType.low,
                              child: Text(low),
                            ),
                            PopupMenuItem<PriorityType>(
                              onTap: () => notePageController.popUpMenuChangeText(text: hight),
                              value: PriorityType.hight,
                              child: Text(
                                hight,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                          child: Text(
                            notePageController.priorityTypeText,
                            style: notePageController.stylePioryty(),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Сделать до',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      /// Выбор даты для заметки
                      AnimatedBuilder(
                        animation: notePageController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: notePageController.switchTurn ? 1.0 : 0.0,
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                if (notePageController.switchTurn) {
                                  notePageController.opencalendar(context);
                                }
                              },
                              child: Text(
                                notePageController.dateBeforCompleteStr,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// Тумблер, что бы можно было выбирать дату
                  AnimatedBuilder(
                    animation: notePageController,
                    builder: (context, child) {
                      return Switch(
                        value: notePageController.switchTurn,
                        onChanged: (value) => notePageController.turnSwitch(),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
