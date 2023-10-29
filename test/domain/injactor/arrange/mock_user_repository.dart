import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:notes/data/models/user_model.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';
import 'package:notes/domain/usecase/user_usecase/update_usecase.dart';

import '../../test_repositories.mocks.dart';

// correct create params
final CreateParamsUser createParams = CreateParamsUser(
  name: 'User',
  avatarUrl: 'avatarUrl',
);

// correct correctUser
const UserModel correctUser = UserModel(
  userId: '1',
  name: 'User',
  avatarUrl: 'avatarUrl',
);

// correct userId
const String userId = '1';

// correct update params
final UpdateParamsUser updateParams = UpdateParamsUser(
  userId: '1',
  avatarUrl: 'avatarUrlTest',
  name: 'UserTest',
);

// correct updateUser

const UserModel updateUser = UserModel(
  userId: '1',
  name: 'UserTest',
  avatarUrl: 'avatarUrlTest',
);

MockUserRepository arrangeMockUserRepository() {
  MockUserRepository mockUserRepository = MockUserRepository();

  //!for create
  when(
    mockUserRepository.createUser(createParams: createParams),
  ).thenAnswer((_) async => const Right(unit));

  ///////////////////////

  //!for update
  when(
    mockUserRepository.updateuser(updateParams: updateParams),
  ).thenAnswer((_) async => const Right(unit));

  ///////////////////////

  //!for getUserById
  when(
    mockUserRepository.getUserById(userId: userId),
  ).thenAnswer((realInvocation) async => const Right(correctUser));

  return mockUserRepository;
}
