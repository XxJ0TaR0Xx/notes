import 'package:flutter/material.dart';
import 'package:notes/utils/app_colors.dart';

class BackContainer extends StatelessWidget {
  final Widget child;
  const BackContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        color: AppColors.backElevatedColor,
      ),
      child: child,
    );
  }
}
