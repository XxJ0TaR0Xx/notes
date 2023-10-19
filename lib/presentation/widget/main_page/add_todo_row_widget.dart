import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/utils/app_colors.dart';

class AddToDoRowWidget extends StatelessWidget {
  final Function function;
  const AddToDoRowWidget({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: function(),
          icon: SvgPicture.asset('assets/icons/add.svg'),
          color: AppColors.colorGray,
        ),
        Expanded(
          child: InkWell(
            onTap: function(),
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
