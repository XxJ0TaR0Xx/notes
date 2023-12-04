import 'package:flutter/material.dart';
import 'package:notes/src/presentation/const/app_colors.dart';

//TODO регистрация, обновления пользователя

class MyEndDrawer extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final Future<void> Function() singOut;

  const MyEndDrawer({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.singOut,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    return Drawer(
      backgroundColor: AppColors.backPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.backElevatedColor,
            ),
            accountName: Text(
              name,
              style: textStyle,
            ),
            accountEmail: Text(
              email,
              style: textStyle,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.backElevatedColor,
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
          ),
          TextButton.icon(
            style: ButtonStyle(
              iconColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {},
            label: const Text(
              'Настройки',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
          TextButton(
            onPressed: () {
              singOut();
            },
            child: Text(
              'Выйти из аккаунта',
              style: TextStyle(
                color: AppColors.colorBlue,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
