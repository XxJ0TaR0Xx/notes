import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/presentation/widget/dismissable_row_widget.dart';
import 'package:notes/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Мои дела',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 4.0),
                  Row(
                    children: [
                      Text(
                        'Выполнено — 5',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lablTertiaryColor,
                        ),
                      ),
                      const Spacer(),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          AppColors.colorBlue,
                          BlendMode.srcIn,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/visibility.svg',
                        ),
                      ),
                      const SizedBox(width: 25.0),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 16.0,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  color: AppColors.backElevatedColor,
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), // Отключаем скроллинг ListView.builder
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return DissmisableRowWidget(
                      functionUpdate: () {
                        print('functionUpdate - work');
                      },
                      functionDismissed: () {
                        print('functionDismissed - work');
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/add.svg'),
                    color: AppColors.colorGray,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Новое',
                        style: TextStyle(
                          color: AppColors.colorGray,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.colorWhite,
            BlendMode.srcIn,
          ),
          child: SvgPicture.asset(
            'assets/icons/add.svg',
          ),
        ),
      ),
    );
  }
}
