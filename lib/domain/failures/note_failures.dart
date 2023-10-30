///ошибки обрабатываемые [NoteRepository]
import 'package:notes/core/failure/failure.dart';

class UserNotExistFailure extends Failure {
  const UserNotExistFailure() : super(message: 'There is no user with this id');
}

///
class FirebaseNoteInternalFailure extends Failure {
  const FirebaseNoteInternalFailure() : super(message: 'Error on the firebase note side');
}

///
//TODO: сделать описание ошибок в message pole
class ExternalNoteFailure extends Failure {
  const ExternalNoteFailure() : super(message: 'Server note error');
}
