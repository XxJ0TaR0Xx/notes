import 'package:flutter/material.dart';
import 'package:notes/core/services/services.dart';
import 'package:notes/src/presentation/const/app_colors.dart';
import 'package:notes/src/presentation/controller/authorization_page_controller.dart';
import 'package:notes/src/presentation/controller/home_page_controller.dart';
import 'package:notes/src/presentation/controller/note_page_controller.dart';
import 'package:notes/src/presentation/page/authorization_page.dart';
import 'package:notes/src/presentation/page/forbidden_page.dart';
import 'package:notes/src/presentation/page/home_page.dart';
import 'package:notes/src/presentation/page/note_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  //?
  // Future<bool> _isFirstLogin() async {
  //   UserDatasourse userDatasourse = services<UserDatasourse>();
  //   String? userId = await userDatasourse.getUserId();
  //   bool isFirstLogin = userId == null;

  //   log("Is first Login $isFirstLogin");
  //   return isFirstLogin;
  // }

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
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            switch (settings.name) {
              case AuthorizationPage.route:
                return AuthorizationPage(
                  authorizationPageControlle: services<AuthorizationPageControlle>(),
                );

              case HomePage.route:
                return HomePage(
                  homePageController: services<HomePageController>(),
                );

              case NotePage.route:
                return NotePage(
                  notePageController: services<NotePageController>(),
                );

              default:
                return const ForbiddenPage();
            }
          },
        );
      },
    );
  }
}
