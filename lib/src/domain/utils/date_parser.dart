import 'package:intl/intl.dart';

/// Форматирование даты для отображения пользователю
String formatDate(DateTime? selectedDate) {
  final formatter = DateFormat('dd MMMM yyyy', 'ru_RU');

  if (selectedDate != null) {
    return formatter.format(selectedDate);
  } else {
    return '';
  }
}
