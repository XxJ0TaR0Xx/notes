import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/core/firebase/firebase_module.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/authorization_page_controller.dart';
import 'package:notes/src/presentation/controller/home_page_controller.dart';
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            homePageController: services<HomePageController>(),
          ),
        ),
      );
    }

    return StreamBuilder(
      //! Временно
      stream: services<FirebaseModule>().auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(
            homePageController: services<HomePageController>(),
            //avatarUrl: authorizationPageControlle.avatarUrl,
          );
        } else {
          return Scaffold(
            backgroundColor: AppColors.backPrimaryColor,
            appBar: AppBar(
              title: Center(
                child: Text(
                  'Авторизация',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              elevation: 0.0,
              backgroundColor: AppColors.backPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: authorizationPageControlle,
                    builder: (context, child) {
                      return TextField(
                        controller: authorizationPageControlle.emailTextController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  AnimatedBuilder(
                    animation: authorizationPageControlle,
                    builder: (BuildContext context, Widget? child) {
                      return TextField(
                        controller: authorizationPageControlle.passwordTextController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Пароль',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  AnimatedBuilder(
                    animation: authorizationPageControlle,
                    builder: (context, child) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          authorizationPageControlle.singIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorGreen,
                        ),
                        icon: const Icon(Icons.lock_open),
                        label: const Text('Войти'),
                      );
                    },
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
      },
    );
  }
}
