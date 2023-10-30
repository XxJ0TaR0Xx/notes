import 'package:notes/src/domain/entities/enums/priority_type.dart';

final class PriorityTypeParser {
  static const low = 'low';
  static const not = 'not';
  static const hight = 'hight';

  static String priorityToStr(PriorityType params) {
    switch (params) {
      case PriorityType.not:
        return not;
      case PriorityType.low:
        return low;
      case PriorityType.hight:
        return hight;
      default:
        throw Exception('Unregistered PriorityType');
    }
  }

  static PriorityType strToPriority(String params) {
    switch (params) {
      case not:
        return PriorityType.not;
      case low:
        return PriorityType.low;
      case hight:
        return PriorityType.hight;
      default:
        throw Exception('[PriorityType] doesn\'t contain this string');
    }
  }
}
