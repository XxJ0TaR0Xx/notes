import 'package:flutter/material.dart';
import 'package:notes/presentation/page/main_page.dart';
import 'package:notes/utils/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
            ),
            titleMedium: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: AppColors.lablTertiaryColor,
            ),
          ),
        ),
        home: const HomePage());
  }
}
