import 'package:notes/domain/enums/impotant_item_enum.dart';

final class ImpParse {
  static const low = 'low';
  static const not = 'not';
  static const hight = 'hight';

  static String impToStr(Imp params) {
    switch (params) {
      case Imp.not:
        return not;
      case Imp.low:
        return low;
      case Imp.hight:
        return hight;
      default:
        throw Exception('unknow params');
    }
  }

  static Imp strToImp(String params) {
    switch (params) {
      case not:
        return Imp.not;
      case low:
        return Imp.low;
      case hight:
        return Imp.hight;
      default:
        throw Exception('unknow params');
    }
  }
}
