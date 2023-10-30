import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

class AddToDoRowWidget extends StatelessWidget {
  final void Function() onPressed;

  const AddToDoRowWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset('assets/icons/add.svg'),
          color: AppColors.colorGray,
        ),
        Expanded(
          child: InkWell(
            onTap: onPressed,
            child: Text(
              'Новое',
              style: TextStyle(
                color: AppColors.colorGray,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
