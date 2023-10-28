import 'package:flutter_test/flutter_test.dart';
import 'package:notes/data/models/user_model.dart';
import 'package:notes/domain/usecase/user_usecase/create_usecase.dart';

void main() {
  const UserModel originalUser = UserModel(
    userId: '123',
    name: 'user',
    avatarUrl: 'sdgfa',
  );

  group('user_model_test', () {
    test('factory fromCreateUserParams', () {
      // Act
      final CreateParamsUser createParamsUser = CreateParamsUser(
        name: 'user',
        avatarUrl: 'sdgfa',
      );

      // Arrange
      final UserModel user = UserModel.fromCreateUserParams(createParamsUser);

      // Accert
      expect(user.name, originalUser.name);
      expect(user.avatarUrl, originalUser.avatarUrl);
    });

    test('method copyWith', () {
      // Act
      const UserModel updateUser = UserModel(
        userId: '123',
        name: 'Daniil',
        avatarUrl: 'qwer',
      );
      // Arrange
      final UserModel result = originalUser.copyWith(
        name: 'Daniil',
        avatarUrl: 'qwer',
      );
      // Accert
      expect(result, updateUser);
    });

    test('method toFirebase', () {
      final Map<String, dynamic> resultUser = {
        'name': 'user',
        'avatarUrl': 'sdgfa',
      };
      // Arrange
      final Map<String, dynamic> result = originalUser.toFirebase();

      // Accert
      expect(result, resultUser);
    });
  });
}
