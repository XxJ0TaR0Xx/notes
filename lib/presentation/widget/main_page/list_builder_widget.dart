import 'package:flutter/material.dart';
import 'package:notes/presentation/widget/row/dismissable_row_widget.dart';

class ListWidget extends StatelessWidget {
  final int lenght;
  final String data;
  final String? date;
  const ListWidget({
    super.key,
    required this.lenght,
    required this.data,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Отключаем скроллинг ListView.builder
      shrinkWrap: true,
      itemCount: lenght,
      itemBuilder: (BuildContext context, int index) {
        return DissmisableRowWidget(
          functionUpdate: () {
            print('functionUpdate - work');
          },
          functionDismissed: () {
            print('functionDismissed - work');
          },
          data: data,
          date: date,
        );
      },
    );
  }
}
