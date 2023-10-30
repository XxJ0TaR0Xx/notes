import 'package:notes/core/failure/failure.dart';

class FirebaseUserInternalFailure extends Failure {
  const FirebaseUserInternalFailure() : super(message: 'Error on the firebase user side');
}

class ExternalUserFailure extends Failure {
  const ExternalUserFailure() : super(message: 'Server user error');
}
