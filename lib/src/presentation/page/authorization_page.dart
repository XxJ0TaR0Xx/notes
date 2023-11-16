import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/authorization_page_controller.dart';
import 'package:notes/src/presentation/page/home_page.dart';

class AuthorizationPage extends StatelessWidget {
  final AuthorizationPageControlle authorizationPageControlle;
  static const String route = '/';

  const AuthorizationPage({
    super.key,
    required this.authorizationPageControlle,
  });

  @override
  Widget build(BuildContext context) {
    FutureOr<void> onPressedAddNote() async {
      Navigator.of(context).pushNamed(HomePage.route);
    }

    return Scaffold(
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Авторизация',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0.0,
        backgroundColor: AppColors.backPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Пароль',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorGreen,
              ),
              child: const Text('Войти'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text('или'),
            const SizedBox(
              height: 8.0,
            ),
            AnimatedBuilder(
              animation: authorizationPageControlle,
              builder: (BuildContext context, Widget? child) {
                return ElevatedButton(
                  onPressed: () {
                    authorizationPageControlle.signInAnonymously();

                    onPressedAddNote();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.colorGray,
                  ),
                  child: const Text('Войти как гость'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}