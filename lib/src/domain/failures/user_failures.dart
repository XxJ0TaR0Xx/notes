import 'package:notes/core/failure/failure.dart';

class FirebaseUserInternalFailure extends Failure {
  const FirebaseUserInternalFailure() : super(message: 'Firebase Internal Failure');
}

class ExternalUserFailure extends Failure {
  const ExternalUserFailure() : super(message: 'External User Failure');
}
