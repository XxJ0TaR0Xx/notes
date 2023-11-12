import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/src/domain/entities/enums/priority_type.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

class MyCheckbox extends StatelessWidget {
  final void Function() updateIsComplete;
  final bool isChecked;
  final PriorityType isImpotant;

  const MyCheckbox({
    super.key,
    required this.updateIsComplete,
    required this.isChecked,
    required this.isImpotant,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;

    if (isChecked) {
      borderColor = AppColors.colorGreen;
    } else {
      if (isImpotant == PriorityType.hight) {
        borderColor = AppColors.colorRed;
      } else {
        borderColor = AppColors.colorGray;
      }
    }

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      child: InkWell(
        onTap: updateIsComplete,
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: isChecked ? AppColors.colorGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 2.0,
              color: borderColor,
            ),
          ),
          child: isChecked ? SvgPicture.asset('assets/icons/check.svg') : null,
        ),
      ),
    );
  }
}
