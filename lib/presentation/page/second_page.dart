import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/presentation/page/main_page.dart';
import 'package:notes/utils/app_colors.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backElevatedColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => const HomePage(),
          icon: SvgPicture.asset('assets/icons/close.svg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('СОХРАНИТЬ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    letterSpacing: 0.16,
                  )),
            ),
          )
        ],
      ),
      body: Container(
        child: const TextField(
          decoration: InputDecoration(hintText: ('Что надо сделать')),
        ),
      ),
    );
  }
}
