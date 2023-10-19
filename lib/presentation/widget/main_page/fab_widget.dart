import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/utils/app_colors.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
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
