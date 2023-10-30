import 'package:notes/core/failure/failure.dart';

class UserNotExistFailure extends Failure {
  const UserNotExistFailure() : super(message: 'User Not Exist Failure');
}

class FirebaseInternalFailure extends Failure {
  const FirebaseInternalFailure() : super(message: 'Firebase Internal Failure');
}

class ExternalFailure extends Failure {
  const ExternalFailure() : super(message: 'Extinternal Failure');
}
