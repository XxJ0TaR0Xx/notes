import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import '../../test_repositories.mocks.dart';

MockUserRepository arrangeMockUserRepository() {
  MockUserRepository mockUserRepository = MockUserRepository();

  //!for create
  // correct
  when(
    mockUserRepository.createUser(createParams: createParams),
  ).thenAnswer((_) async => Right(correctUser));

  //incorrect
  when(mockUserRepository.createUser(createParams: incorrectCreateParams),).thenAnswer((realInvocation) => Left())
}
