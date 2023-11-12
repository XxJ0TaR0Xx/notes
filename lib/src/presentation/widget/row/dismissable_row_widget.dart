import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/widget/row/todo_row_widget.dart';

class DissmisableRowWidget extends StatelessWidget {
  final void Function() functionUpdate;
  final Function functionDismissed;
  final bool isComplete;
  final String keyItem;
  final String data;
  final String? date;
  final PriorityType priorityType;

  const DissmisableRowWidget({
    super.key,
    required this.priorityType,
    required this.isComplete,
    required this.functionUpdate,
    required this.functionDismissed,
    required this.data,
    required this.keyItem,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(keyItem),
      // ignore: body_might_complete_normally_nullable
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          functionDismissed();
        } else if (direction == DismissDirection.startToEnd) {
          functionUpdate();
        }
      },

      /// Обноваить заметку
      background: Container(
        color: AppColors.colorGreen,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16.0),
        child: SvgPicture.asset(
          'assets/icons/check.svg',
          // ignore: deprecated_member_use
          color: AppColors.colorWhite,
        ),
      ),

      /// Удалить заметку
      secondaryBackground: Container(
        color: AppColors.colorRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: SvgPicture.asset(
          'assets/icons/delete.svg',
          // ignore: deprecated_member_use
          color: AppColors.colorWhite,
        ),
      ),

      /// Сама строка заметки
      child: TodoRowWodget(
        updateIsComplete: functionUpdate,
        priorityType: priorityType,
        isComplete: isComplete,
        data: data,
        dateBeforComplete: date,
      ),
    );
  }
}
