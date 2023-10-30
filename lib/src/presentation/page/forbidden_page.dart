import 'package:flutter/material.dart';

class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
