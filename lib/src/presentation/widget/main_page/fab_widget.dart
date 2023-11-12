import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

class FabWidget extends StatelessWidget {
  final void Function() onPressed;
  const FabWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          AppColors.colorWhite,
          BlendMode.srcIn,
        ),
        child: SvgPicture.asset(
          'assets/icons/add.svg',
        ),
      ),
    );
  }
}
