import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/widget/row/todo_row_widget.dart';

class DissmisableRowWidget extends StatelessWidget {
  final Function functionUpdate;
  final Function functionDismissed;
  final String data;
  final String? date;
  const DissmisableRowWidget({
    super.key,
    required this.functionUpdate,
    required this.functionDismissed,
    required this.data,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('item'),

      //todo перечеркнутый текст
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
      child: TodoRowWodget(
        data: data,
        date: date,
      ),
    );
  }
}
