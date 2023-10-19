import 'package:flutter/material.dart';

class ImpotantRowWidget extends StatelessWidget {
  const ImpotantRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Важность',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Обычная',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(),
        Switch(
          value: true,
          onChanged: (ad) {},
        )
      ],
    );
  }
}
