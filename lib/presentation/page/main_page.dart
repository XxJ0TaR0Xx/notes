import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/presentation/widget/dismissable_row_widget.dart';
import 'package:notes/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backElevatedColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //передача
                  'Мои дела',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 4.0),
                Row(
                  children: [
                    Text(
                      //передача
                      'Выполнено — 5',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lablTertiaryColor,
                      ),
                    ),
                    const Spacer(),
                    //TODO iconButton turn
                    SvgPicture.asset(
                      'assets/icons/visibility.svg',
                      // ignore: deprecated_member_use
                      color: AppColors.colorBlue,
                    ),
                    const SizedBox(width: 25.0),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 16.0,
              ),
              child: ColoredBox(
                color: AppColors.colorBlue,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return const DissmisableRowWidget();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
