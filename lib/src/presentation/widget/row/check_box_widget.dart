import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

// ignore: must_be_immutable
class MyCheckbox extends StatefulWidget {
  bool isChecked;
  final bool isImpotant;

  MyCheckbox({
    super.key,
    required this.isChecked,
    required this.isImpotant,
  });

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    Color borderColor;

    if (widget.isChecked) {
      borderColor = AppColors.colorGreen;
    } else {
      if (widget.isImpotant) {
        borderColor = AppColors.colorRed;
      } else {
        borderColor = AppColors.colorGray;
      }
    }

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isChecked = !widget.isChecked;
          });
        },
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: widget.isChecked ? AppColors.colorGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 2.0,
              color: borderColor,
            ),
          ),
          child: widget.isChecked ? SvgPicture.asset('assets/icons/check.svg') : null,
        ),
      ),
    );
  }
}
