import 'dart:async';

import 'package:notes/core/validator/validator.dart';

class AddDataNoteValidator extends Validator<String?> {
  @override
  FutureOr<bool> validate(String? t) {
    if (t == null || t == '') {
      return false;
    } else {
      return true;
    }
  }
}
