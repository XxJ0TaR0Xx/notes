import 'dart:async';

import 'package:notes/core/validator/validator.dart';

class DataValidator extends Validator {
  @override
  FutureOr<bool> validate(t) {
    if (t == '') {
      return false;
    } else {
      return true;
    }
  }
}
