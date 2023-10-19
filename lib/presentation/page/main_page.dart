import 'package:flutter/material.dart';
import 'package:notes/presentation/widget/main_page/add_todo_row_widget.dart';
import 'package:notes/presentation/widget/main_page/back_container_widget.dart';
import 'package:notes/presentation/widget/main_page/container_for_add_row_widget.dart';
import 'package:notes/presentation/widget/main_page/fab_widget.dart';
import 'package:notes/presentation/widget/main_page/list_builder_widget.dart';
import 'package:notes/presentation/widget/main_page/my_tasks_widget.dart';
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
            const Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                  left: 60.0,
                ),
                child: MyTasksWidget(
                  count: 5,
                  iconPath: 'assets/icons/visibility.svg',
                )),
            const Padding(
              padding: EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 16.0,
              ),
              child: BackContainer(
                child: ListWidget(
                  lenght: 5,
                  data: 'Купить сам финг',
                  date: '21.02.12',
                ),
              ),
            ),
            ContainerForRowWidget(
              child: AddToDoRowWidget(
                function: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FabWidget(),
    );
  }
}
