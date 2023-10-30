import 'package:flutter/material.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

class ContainerForRowWidget extends StatelessWidget {
  final Widget child;
  const ContainerForRowWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 8.0,
        left: 8.0,
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.backElevatedColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: child,
    );
  }
}
