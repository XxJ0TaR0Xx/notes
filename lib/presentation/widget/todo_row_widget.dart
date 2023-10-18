import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/presentation/widget/check_box_widget.dart';

class TodoRowWodget extends StatelessWidget {
  const TodoRowWodget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      child: Row(
        children: [
          MyCheckbox(
            isChecked: false,
            isImpotant: false,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Купить что-то',
                  //?.copyWith(color: Colors.red)
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Дата',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/info_outline.svg'),
          )
        ],
      ),
    );
  }
}
