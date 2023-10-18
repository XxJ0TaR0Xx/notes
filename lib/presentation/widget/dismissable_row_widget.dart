import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/presentation/widget/todo_row_widget.dart';
import 'package:notes/utils/app_colors.dart';

class DissmisableRowWidget extends StatelessWidget {
  const DissmisableRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('item'),
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
      child: const TodoRowWodget(),
    );
  }
}
