import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/widget/row/check_box_widget.dart';

class TodoRowWidget extends StatelessWidget {
  final String data;
  final String? dateBeforComplete;
  final bool isComplete;
  final PriorityType priorityType;
  final void Function() updateIsComplete;
  final void Function() toUpdateNote;
  const TodoRowWidget({
    super.key,
    required this.updateIsComplete,
    required this.priorityType,
    required this.isComplete,
    required this.data,
    required this.toUpdateNote,
    this.dateBeforComplete,
  });

  TextStyle checkText() {
    if (isComplete) {
      return TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lablTertiaryColor,
        decoration: TextDecoration.lineThrough,
        decorationColor: AppColors.lablTertiaryColor,
      );
    } else {
      return const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      );
    }
  }

  String dateBeforCompleteCheck() {
    if (dateBeforComplete == 'null' || dateBeforComplete == null) {
      return '';
    } else {
      return dateBeforComplete!;
    }
  }

  List<Widget> checkPriority({required Text text}) {
    switch (priorityType) {
      case PriorityType.low:
        return [
          SvgPicture.asset(
            'assets/icons/low_priority.svg',
            height: 16.0,
            width: 16.0,
          ),
          const SizedBox(width: 3.0),
          text,
        ];
      case PriorityType.hight:
        return [
          SvgPicture.asset(
            'assets/icons/hight_priority.svg',
            height: 16.0,
            width: 16.0,
          ),
          const SizedBox(width: 3.0),
          text,
        ];
      default:
        return [text];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      child: Row(
        children: [
          MyCheckbox(
            updateIsComplete: updateIsComplete,
            isChecked: isComplete,
            isImpotant: priorityType,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: checkPriority(
                    text: Text(
                      data,
                      style: checkText(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  dateBeforCompleteCheck(),
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: toUpdateNote,
            icon: SvgPicture.asset('assets/icons/info_outline.svg'),
          )
        ],
      ),
    );
  }
}
