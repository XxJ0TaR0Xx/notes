import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/domain/utils/priority_type_parser.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/home_page_controller.dart';
import 'package:notes/src/presentation/controller/note_page_controller.dart';
import 'package:notes/src/presentation/page/home_page.dart';

class NotePage extends StatelessWidget {
  static const String route = '/home/note';
  final NotePageController notePageController;

  final String? updateData;
  final PriorityType? updatePriorityType;
  final DateTime? updateDateBeforComplete;
  final String? updateNoteId;

  const NotePage({
    super.key,
    required this.notePageController,
    this.updateData,
    this.updatePriorityType,
    this.updateDateBeforComplete,
    this.updateNoteId,
  });

  @override
  Widget build(BuildContext context) {
    notePageController.showUpdateFields(
      updatePriorityType: updatePriorityType,
      updateData: updateData,
      updateDateBeforComplete: updateDateBeforComplete,
    );

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
                    if (!notePageController.isUpdate) {
                      notePageController.createNote(
                        context: context,
                      );
                    } else {
                      notePageController.updateNote(
                        noteId: updateNoteId!,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            homePageController: services<HomePageController>(),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                      letterSpacing: 0.16,
                      color: Colors.blueAccent,
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
                      controller: notePageController.textDataController,
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
                              onTap: () => notePageController.popUpMenuChangeText(text: PriorityTypeParser.notRu),
                              value: PriorityType.not,
                              child: const Text(PriorityTypeParser.notRu),
                            ),
                            PopupMenuItem<PriorityType>(
                              onTap: () => notePageController.popUpMenuChangeText(text: PriorityTypeParser.lowRu),
                              value: PriorityType.low,
                              child: const Text(PriorityTypeParser.lowRu),
                            ),
                            PopupMenuItem<PriorityType>(
                              onTap: () => notePageController.popUpMenuChangeText(text: PriorityTypeParser.hightRu),
                              value: PriorityType.hight,
                              child: const Text(
                                PriorityTypeParser.hightRu,
                                style: TextStyle(color: Colors.red),
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
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
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
                        activeTrackColor: AppColors.backPrimaryColor,
                        activeColor: Colors.blueAccent,
                        inactiveThumbColor: Colors.blueAccent,
                        inactiveTrackColor: AppColors.backPrimaryColor,
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
