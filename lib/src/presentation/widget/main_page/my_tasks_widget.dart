import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

class MyTasksWidget extends StatelessWidget {
  final int count;
  final String iconPath;
  final void Function() onPressed;
  const MyTasksWidget({
    super.key,
    required this.onPressed,
    required this.count,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Мои дела',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(width: 4.0),
        Row(
          children: [
            Text(
              'Выполнено — $count',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: AppColors.lablTertiaryColor,
              ),
            ),
            const Spacer(),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppColors.colorBlue,
                BlendMode.srcIn,
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  iconPath,
                ),
                onPressed: onPressed,
              ),
            ),
            const SizedBox(width: 25.0),
          ],
        ),
      ],
    );
  }
}
