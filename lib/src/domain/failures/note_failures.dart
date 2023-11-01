import 'package:notes/core/failure/failure.dart';

final class UserNotExistFailure extends Failure {
  const UserNotExistFailure();
}

final class FirebaseInternalFailure extends Failure {
  const FirebaseInternalFailure();
}

final class ExternalFailure extends Failure {
  const ExternalFailure();
}
