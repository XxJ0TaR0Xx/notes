import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:notes/utils/app_colors.dart';
import 'package:notes/utils/impotant_item_enum.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  ImportantItem? selectedMenu;
  String text = 'Нет';
  String dateStr = '';
  bool switchTurn = false;

  String formatDate(DateTime selectedDate) {
    final formatter = DateFormat('dd MMMM yyyy', 'ru_RU');
    return formatter.format(selectedDate);
  }

  void opencalendar(BuildContext context) async {
    DateTime? selectedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 400,
            width: double.infinity,
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20),
              focusedDay: DateTime.now(),
              headerVisible: true,
              daysOfWeekVisible: true,
              sixWeekMonthsEnforced: true,
              shouldFillViewport: false,
              headerStyle: const HeaderStyle(titleTextStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.w800)),
              calendarStyle: const CalendarStyle(todayTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              onDaySelected: (selectedDay, focusedDay) {
                Navigator.of(context).pop(selectedDay);
              },
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        dateStr = formatDate(selectedDate); // Форматируйте выбранную дату по вашему желанию
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backPrimaryColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // Возвращаемся на предыдущий экран
          },
          icon: SvgPicture.asset('assets/icons/close.svg'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // Обработка нажатия кнопки "СОХРАНИТЬ"
              },
              child: const Text(
                'СОХРАНИТЬ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  letterSpacing: 0.16,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backElevatedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: const SizedBox(width: 16.0),
                        hintText: 'Что надо сделать...',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lablTertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Важность',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4.0),
                    PopupMenuButton<ImportantItem>(
                      initialValue: selectedMenu,
                      onSelected: (ImportantItem item) {
                        setState(
                          () {
                            selectedMenu = item;
                          },
                        );
                      },
                      itemBuilder: (context) => <PopupMenuEntry<ImportantItem>>[
                        PopupMenuItem<ImportantItem>(
                          onTap: () => text = 'Нет',
                          value: ImportantItem.not,
                          child: const Text('Нет'),
                        ),
                        PopupMenuItem<ImportantItem>(
                          onTap: () => text = 'Низкая',
                          value: ImportantItem.low,
                          child: const Text('Низкая'),
                        ),
                        PopupMenuItem<ImportantItem>(
                          onTap: () => text = 'Высокая',
                          value: ImportantItem.hight,
                          child: const Text(
                            'Высокая',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(height: 0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Сделать до',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          opencalendar(context);
                        },
                        child: Text(
                          dateStr,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: switchTurn,
                    onChanged: (p) {
                      setState(() {
                        switchTurn = !switchTurn;
                        if (!switchTurn) {
                          dateStr = '';
                        } else {
                          dateStr = 'Выберите дату';
                        }
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
