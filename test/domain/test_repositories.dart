// ignore_for_file: unused_import

import 'package:mockito/annotations.dart';
import 'package:notes/domain/repositories/note_repository.dart';
import 'package:notes/domain/repositories/user_repository.dart';

@GenerateNiceMocks([MockSpec<NoteRepository>(), MockSpec<UserRepository>()])
import 'test_repositories.mocks.dart';
